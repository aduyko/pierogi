require_relative "../lib/github_request_handler.rb"

handler_config = {
  "repositories" => {
    "website" => [
      {
        "branch" => "master_validscript",
        "script" => "spec/fixture/files/test_script.sh"
      },
      {
        "branch" => "master_noscript"
      }
    ]
  }
}

describe GithubRequestHandler do
  it "Should handle request for valid repo, branch, and script" do
    request = {
      "ref" => "refs/heads/master_validscript",
      "repository" => {
        "name" => "website"
      }
    }
    expect(GithubRequestHandler.new(handler_config).handle_request(request)).to be_nil
  end

  it "Should fail request for valid repo, invalid branch" do
    request = {
      "ref" => "refs/heads/master2",
      "repository" => {
        "name" => "website"
      }
    }
    expect(GithubRequestHandler.new(handler_config).handle_request(request)).to eq("No script found for branch master2 in configuration")
  end

  it "Should fail request for invalid repo, valid branch" do
    request = {
      "ref" => "refs/heads/master_noscript",
      "repository" => {
        "name" => "website2"
      }
    }
    expect(GithubRequestHandler.new(handler_config).handle_request(request)).to eq("No valid 'repository' key found in request json")
  end
end
