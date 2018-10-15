require "roda"
require "open3"
require_relative "cfg/config.rb"

class Pierogi < Roda
  plugin :slash_path_empty
  plugin :json_parser

  route do |r|
    r.is "github" do
      # TODO: Something like this
      # @handler = new this.getHandler(config.routes."github")
      # @handler = new GithubHandler()
      r.post do
        # r.params is a map, json is parsed automatically by the json_parser plugin
        # if our request is content type application/json
        err = handle_github_request(r.params)
        # TODO: Something like this
        err = @handler.handle(r.params)
        # TODO: Should be json responses (status: ok) or whatever
        if err.nil?
          "Script executed!"
        else
          response.status = 400
          "Error: #{err}"
        end
      end
    end

    r.on "test" do
      r.get do
        "Hello World\n"
      end
      r.post do
        # r.params is a map, json is parsed automatically by the json_parser plugin
        # if our request is content type application/json
        err = handle_request(r.params)
        # TODO: Should be json responses (status: ok) or whatever
        if err.nil?
          "Script executed!"
        else
          response.status = 400
          "Error: #{err}"
        end
      end
    end
  end
end

# TODO: Create a handler class that does this
def handle_github_request(params)
  # If we're in the right repo
  if params["repository"] && params["repository"]["name"] && params["repository"]["name"] == REPO_NAME
    puts "Github repository name matches '#{REPO_NAME}'"
    # Switch on the branch - github webhook format:
    # "ref": "refs/heads/#{branch_name}"
    branch = params["ref"].split("/")[-1]
    puts "Attempting to run tests for branch #{branch}"
    case branch
    when "pierogi_dev"
      execute_script("foo.sh")
    when "master"
      execute_script("foo2.sh")
    else
      "No valid branch found in request json"
    end
  else
      "No valid 'repository' key found in request json"
  end
end

def handle_request(params)
  if params.has_key? "script"
    execute_script(params["script"])
  else
    "No 'script' key found in request json"
  end
end

def execute_script(script)
  begin
    puts "START: Attempting to execute script #{SCRIPTS_PATH}/#{script}"
    stdin, stdout, wait_thr = Open3.popen2e("#{SCRIPTS_PATH}/#{script}")
    stdin.close
    puts stdout.gets(nil)
    stdout.close
    exit_code = wait_thr.value
    puts exit_code.exitstatus
    puts exit_code
    if exit_code.success?
      puts "END: Script execution succeeded"
      nil
    else
      "Script Execution Failed"
    end
  rescue Exception => e
    err = "#{e.class}, #{e.message}"
    puts "END: Error: #{err}"
    err
  end
end
