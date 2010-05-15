require 'webrick'
require 'logger'

TEST_SERVER_PORT = 13245

class TestServer
  include WEBrick

  def initialize
    test_proc = lambda do |req, resp|
      resp['Content-Type'] = "text/html"
      resp.body = '*' * req.query['size'].to_i
    end

    test_handler = HTTPServlet::ProcHandler.new(test_proc)
    @server = HTTPServer.new(:Port => TEST_SERVER_PORT, :Logger => Logger.new('/dev/null'))
    @server.mount("/", test_handler)
    trap("INT"){ @server.shutdown }
    @server.start
  end
end
