# frozen_string_literal: true

control "nginx_service" do
  describe "service status" do
    subject do
      command("sudo service nginx status | grep Active:").stdout
    end

    it "is RUNNING" do
      is_expected.to match /active/
    end
  end

  describe port(80) do
    it { should be_listening }
  end

  describe "the configuration" do
    subject do
      command("curl localhost").stdout
    end

    it 'redirects on port 8080' do
      is_expected.to match /<html>/
      is_expected.to match /You are authenticated as: anonymous/
      is_expected.to match /hudson\.model\.Hudson\.Administer/
      is_expected.to match /<\/body><\/html>/
    end
  end
end