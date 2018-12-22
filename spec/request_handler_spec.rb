require_relative "../lib/request_handler.rb"

describe RequestHandler do
  it "Should not handle request from abstract class" do
    expect(RequestHandler.new.handle_request).to eq("No handle_request function exists for class RequestHandler")
  end

  it "Should run test script" do
    expect(RequestHandler.new.execute_script('spec/fixture/files/test_script.sh')).to be_nil
  end

  it "Should fail bad test script" do
    expect(RequestHandler.new.execute_script('spec/fixture/files/test_script_failure.sh')).to eq("Script Execution Failed")
  end

  it "Should fail non-existant test script" do
    expect(RequestHandler.new.execute_script('fake_file')).to eq("Errno::ENOENT, No such file or directory - fake_file")
  end
end
