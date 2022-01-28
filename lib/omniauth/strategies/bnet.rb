require 'omniauth-oauth2'
require 'base64'

module OmniAuth
  module Strategies
    class Bnet < OmniAuth::Strategies::OAuth2
      option :region, 'us'
      option :client_options, {
        scope: 'wow.profile sc2.profile'
      }

      def client
        host = get_host(options.region)
        # Setup urls based on region option
        set_client_url(:authorize_url, "https://#{host}/oauth/authorize")
        set_client_url(:token_url, "https://#{host}/oauth/token")
        set_client_url(:site, "https://#{host}/")

        super
      end

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        raw_info
      end

      def raw_info
        return @raw_info if @raw_info

        access_token.options[:mode] = :query

        @raw_info = access_token.get('oauth/userinfo').parsed
      end

      private

      def set_client_url(key, default_url)
        return if options.client.include?(key)

        options.client_options[key] = default_url
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def get_host(region)
        region == 'cn' ? 'www.battlenet.com.cn' : "#{region}.battle.net"
      end
    end
  end
end
