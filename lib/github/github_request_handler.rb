require_relative "../request_handler.rb"

class GithubRequestHandler < RequestHandler
  # input data format:
  # repo:
  #   - branch: #{branch}
  #     script: #{script}
  #   - branch: #{branch}
  #     script: #{script}

  # format input data like so:
  # repo:
  #   branch: script
  #   branch: script
  def initialize(data)
    @repositories = Hash.new
    puts "SETUP: Initializing Github Request Handler with Data: #{JSON.pretty_generate(data)}"
    data.each do |repo_name, branches|
      @repositories["#{repo_name}"] = Hash.new 
      branches.each do |branch_map|
        @repositories[repo_name][branch_map["branch"]] = branch_map["script"]
      end
    end
  end

  def handle_request(params)
    # If repository should be handled
    if params["repository"] && params["repository"]["name"] && !@repositories[params["repository"]["name"]].nil?
      repo_name = params["repository"]["name"]
      puts "INFO: Github repository name #{repo_name}"
      # github webhook format:
      # "ref": "refs/heads/#{branch_name}"
      branch = params["ref"].split("/")[-1]
      script = @repositories[repo_name][branch]
      if branch.nil?
        puts "ERROR: No branch matching #{branch} found in request json"
        "No branch matching #{branch} found in request json"
      elsif script.nil?
        puts "ERROR: No script found for branch #{branch} in configuration"
        "No script found for branch #{branch} in configuration"
      else
        puts "Attempting to run script '#{script}' for branch '#{branch}'"
        self.execute_script(script)
      end
    else
        puts "ERROR: No valid 'repository' key found in request json"
        "No valid 'repository' key found in request json"
    end
  end
end
