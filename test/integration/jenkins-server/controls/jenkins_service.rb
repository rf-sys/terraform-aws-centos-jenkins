# frozen_string_literal: true

control "jenkins_service" do
  describe "service status" do
    subject do
      command("sudo service jenkins status | grep Active:").stdout
    end

    it "is RUNNING" do
      is_expected.to match /active/
    end
  end

  describe port(8080) do
    it { should be_listening }
  end
end