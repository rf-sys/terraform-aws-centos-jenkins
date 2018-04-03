# frozen_string_literal: true

control "operating_system" do
  describe "the operating system" do
    subject do
      command("cat /etc/*-release").stdout
    end

    it "is CentOS 7" do
      is_expected.to match /CentOS Linux 7 \(Core\)"/
    end
  end
end