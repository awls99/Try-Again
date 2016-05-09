#@version 2
#@author Arthur
module TryAgain
#@param options [Hash] (:sleep => number, :attempts => number, :error => Error, :kill => boolean)
#@param block [Block] block of code to be attempted
#@return [Boolean]
    def self.retry( sleep: 3, attempts: 3, error: StandardError, kill: false, output: nil, &block )
        tries||=0
        tries+=1
        out      = output
        if out and !out.respond_to? :puts
            raise InvalidOutput
        end
        attempted = 0
        failed    = false

        begin
            yield
        rescue error => e
            attempted += 1
            out.puts "#{ error.to_s } for the #{tries}# attempt" if out
            if attempted < attempts
                sleep sleep
                retry
            end
            out.puts "#Giving up on #{ error.to_s }, too many attempts" if out
            raise e if kill
            failed = true
        end
        if !failed and out
            out.puts "#{ error.to_s } took #{tries} attempts to pass"
        end
        return !failed
    end

    class InvalidOutput < StandardError; end
end
