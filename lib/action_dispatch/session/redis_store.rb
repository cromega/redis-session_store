require 'oj'

module ActionDispatch
  module Session
    class RedisStore < ActionDispatch::Session::AbstractStore
      def initialize(app, options = {})
        super
        @connection = options.delete(:connection)
        @expiry = options.fetch(:expire_after) { 2.weeks }
      end

      def get_session(env, session_id)
        session_id ||= generate_sid
        key = redis_key(session_id)

        if @connection.exists(key)
          session_data = Oj.load(@connection.get(key))
        else
          session_data = {}

          @connection.pipelined do
            @connection.set(key, Oj.dump(session_data))
            @connection.expire(key, @expiry)
          end
        end

        [session_id, session_data]
      end

      def set_session(env, session_id, session_data, options)
        data = Oj.dump(session_data)
        key = redis_key(session_id)
        ttl = @connection.ttl(key)

        @connection.pipelined do
          @connection.set(key, data)
          @connection.expire(key, ttl)
        end

        session_id
      end

      def destroy_session(env, session_id, options)
        key = redis_key(session_id)
        @connection.del(key)

        generate_sid
      end

      private

      def redis_key(session_id)
        "session:#{session_id}"
      end
    end
  end
end
