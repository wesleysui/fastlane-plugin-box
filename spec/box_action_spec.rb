describe Fastlane::Actions::BoxAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The box plugin is working!")

      Fastlane::Actions::BoxAction.run(nil)
    end
  end
end
