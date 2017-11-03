module Fastlane
  module Actions
    class BoxAction < Action
      def self.run(params)
        UI.message("The box plugin is working!")
        ipa_file = params[:ipa]
        client = Boxr::Client.new  #uses ENV['BOX_DEVELOPER_TOKEN']
        # folder = client.folder_from_path('/some/directory/structure')
        # file = client.upload_file(ipa_file, folder)
        file = client.upload_file(ipa_file)
        updated_file = client.create_shared_link_for_file(file, access: :open)
        puts "Shared Link: #{updated_file.shared_link.url}"
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
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "BOX_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
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
