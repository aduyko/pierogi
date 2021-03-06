require "open3"
require_relative "../config/config.rb"

# This class should not be implemented!!
class RequestHandler
  # TODO: Create a handler class that does this
  # TODO: This might be a bad idea in the generic RequestHandler
  def handle_request()
    "No handle_request function exists for class #{self.class.name}"
  end

  def execute_script(script)
    begin
      puts "START: Attempting to execute script #{script}"
      stdin, stdout, wait_thr = Open3.popen2e("#{script}")
      stdin.close
      puts stdout.gets(nil)
      stdout.close
      exit_code = wait_thr.value
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
end
