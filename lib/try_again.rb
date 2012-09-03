#@version 1
#@author Arthur
module TryAgain
#@param options [Hash] (:sleep => number, :attempts => number, :error => Error, :kill => boolean)
#@param block [Block] block of code to be attempted
#@return [Boolean]
    def self.retry( options={}, &block )
        defaults = { :sleep => 3, :attempts => 3, :error => StandardError, :kill => false, :output => nil }
        options  = defaults.merge options
        out      = options[:output]
        if out and !out.is_a? IO
            raise InvalidOutput
        end
        attempts = 0
        failed   = false

        begin
            yield
        rescue options[:error]
            attempts += 1
            out.puts "#{ options[:error].to_s } for the #{attempts}# attempt" if out
            if attempts < options[:attempts]
                sleep options[:sleep]
                retry
            end
            out.puts "#Giving up on #{ options[:error].to_s }, too many attempts" if out
            raise options[:error] if options[:kill]
            failed = true
        end
        if !failed and out
            out.puts "#{ options[:error].to_s } took #{attempts + 1} attempts to pass"
        end
        return !failed
    end

    class InvalidOutput < StandardError; end
end
