require 'boxr'

module Fastlane
  module Actions
    class BoxAction < Action
      def self.run(params)
        Actions.verify_gem!('boxr')
        ipa_file = params[:ipa]
        UI.message("filename: #{ipa_file}")

        #JWT methods
        token = Boxr::get_enterprise_token(private_key: ENV['JWT_PRIVATE_KEY'],
                                    private_key_password: ENV['JWT_PRIVATE_KEY_PASSWORD'],
                                    public_key_id: ENV['JWT_PUBLIC_KEY_ID'],
                                    enterprise_id: ENV['BOX_ENTERPRISE_ID'],
                                    client_id: ENV['BOX_CLIENT_ID'],
                                    client_secret: ENV['BOX_CLIENT_SECRET'])


        # client = Boxr::Client.new  #uses ENV['BOX_DEVELOPER_TOKEN']
        client = Boxr::Client.new(token)

        folder = client.folder_from_path('/')
        client.create_folder()
        file = client.upload_file(ipa_file, folder)
        updated_file = client.create_shared_link_for_file(file, access: :open)
        puts "Shared Link: #{updated_file.shared_link.url}"

        # items = client.folder_items(Boxr::ROOT)
        # items.each {|i| puts i.name}
      end

      def self.description
        "library for the Box Content API"
      end

      def self.authors
        ["Wesley Sui"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :ipa,
                                  env_name: "BOX_IPA_FILE",
                               description: "the provided ipa file name",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
