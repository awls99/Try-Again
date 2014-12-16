#@version 2
#@author Arthur
module TryAgain
#@param options [Hash] (:sleep => number, :attempts => number, :error => Error, :kill => boolean)
#@param block [Block] block of code to be attempted
#@return [Boolean]
    def self.retry( sleep: 3, attempts: 3, error: StandardError, kill: false, output: nil, &block )
        out      = output
        if out and !out.is_a? IO
            raise InvalidOutput
        end
        attempted = 0
        failed    = false

        begin
            yield
        rescue error => e
            attempted += 1
            out.puts "#{ error.to_s } for the #{attempts}# attempt" if out
            if attempted < attempts
                sleep sleep
                retry
            end
            out.puts "#Giving up on #{ error.to_s }, too many attempts" if out
            raise e if kill
            failed = true
        end
        if !failed and out
            out.puts "#{ error.to_s } took #{attempts + 1} attempts to pass"
        end
        return !failed
    end

    class InvalidOutput < StandardError; end
end
