require 'ffi'

class Kurl
  extend ::FFI::Library
  ffi_lib 'libcurl'

  CURLOPT_URL = 10002
  CURLOPT_WRITEFUNCTION = 20011
  CURLOPT_TIMEOUT = 13
  CURLOPT_NOPROGRESS = 43
  CURLOPT_PROGRESSFUNCTION = 20056
  CURLOPT_FOLLOWLOCATION = 52
  CURLOPT_FORBID_REUSE = 75
  CURLOPT_VERBOSE = 41
  CURLOPT_ERRORBUFFER =  10010

  # libcurl error codes
  CURLcode = enum [ 
    :ok, 0,
    :unsupported_protocol,    # 1
    :failed_init,             # 2
    :url_malformat,           # 3
    :obsolete4,               # 4 - NOT USED
    :couldnt_resolve_proxy,   # 5
    :couldnt_resolve_host,    # 6
    :couldnt_connect,         # 7
    :ftp_weird_server_reply,  # 8
    :remote_access_denied,    # 9 a service was denied by the server
                                   #   due to lack of access - when login fails
                                   #   this is not returned.
    :obsolete10,              # 10 - NOT USED
    :ftp_weird_pass_reply,    # 11
    :obsolete12,              # 12 - NOT USED
    :ftp_weird_pasv_reply,    # 13
    :ftp_weird_227_format,    # 14
    :ftp_cant_get_host,       # 15
    :obsolete16,              # 16 - NOT USED
    :ftp_couldnt_set_type,    # 17
    :partial_file,            # 18
    :ftp_couldnt_retr_file,   # 19
    :obsolete20,              # 20 - NOT USED
    :quote_error,             # 21 - quote command failure
    :http_returned_error,     # 22
    :write_error,             # 23
    :obsolete24,              # 24 - NOT USED
    :upload_failed,           # 25 - failed upload "command"
    :read_error,              # 26 - couldn't open/read from file
    :out_of_memory,           # 27
    # Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
    #       instead of a memory allocation error if CURL_DOES_CONVERSIONS
    #       is defined
    :operation_timedout,      # 28 - the timeout time was reached
    :obsolete29,              # 29 - NOT USED
    :ftp_port_failed,         # 30 - FTP PORT operation failed
    :ftp_couldnt_use_rest,    # 31 - the REST command failed
    :obsolete32,              # 32 - NOT USED
    :range_error,             # 33 - RANGE "command" didn't work
    :http_post_error,         # 34
    :ssl_connect_error,       # 35 - wrong when connecting with SSL
    :bad_download_resume,     # 36 - couldn't resume download
    :file_couldnt_read_file,  # 37
    :ldap_cannot_bind,        # 38
    :ldap_search_failed,      # 39
    :obsolete40,              # 40 - NOT USED
    :function_not_found,      # 41
    :aborted_by_callback,     # 42
    :bad_function_argument,   # 43
    :obsolete44,              # 44 - NOT USED
    :interface_failed,        # 45 - CURLOPT_INTERFACE failed
    :obsolete46,              # 46 - NOT USED
    :too_many_redirects,      # 47 - catch endless re-direct loops
    :unknown_telnet_option,   # 48 - User specified an unknown option
    :telnet_option_syntax,    # 49 - Malformed telnet option
    :obsolete50,              # 50 - NOT USED
    :peer_failed_verification, # 51 - peer's certificate or fingerprint wasn't verified fine
    :got_nothing,             # 52 - when this is a specific error
    :ssl_engine_notfound,     # 53 - SSL crypto engine not found
    :ssl_engine_setfailed,    # 54 - can not set SSL crypto engine as default
    :send_error,              # 55 - failed sending network data
    :recv_error,              # 56 - failure in receiving network data
    :obsolete57,              # 57 - NOT IN USE
    :ssl_certproblem,         # 58 - problem with the local certificate
    :ssl_cipher,              # 59 - couldn't use specified cipher
    :ssl_cacert,              # 60 - problem with the CA cert (path?)
    :bad_content_encoding,    # 61 - Unrecognized transfer encoding
    :ldap_invalid_url,        # 62 - Invalid LDAP URL
    :filesize_exceeded,       # 63 - Maximum file size exceeded
    :use_ssl_failed,          # 64 - Requested FTP SSL level failed
    :send_fail_rewind,        # 65 - Sending the data requires a rewind that failed
    :ssl_engine_initfailed,   # 66 - failed to initialise ENGINE
    :login_denied,            # 67 - user password or similar was not accepted and we failed to login
    :tftp_notfound,           # 68 - file not found on server
    :tftp_perm,               # 69 - permission problem on server
    :remote_disk_full,        # 70 - out of disk space on server
    :tftp_illegal,            # 71 - Illegal TFTP operation
    :tftp_unknownid,          # 72 - Unknown transfer ID
    :remote_file_exists,      # 73 - File already exists
    :tftp_nosuchuser,         # 74 - No such user
    :conv_failed,             # 75 - conversion failed
    :conv_reqd,               # 76 - caller must register conversion callbacks using curl_easy_setopt options
                                   #   CURLOPT_CONV_FROM_NETWORK_FUNCTION,
                                   #   CURLOPT_CONV_TO_NETWORK_FUNCTION, and
                                   #   CURLOPT_CONV_FROM_UTF8_FUNCTION
    :ssl_cacert_badfile,      # 77 - could not load cacert file missing or wrong format
    :remote_file_not_found,   # 78 - remote file not found
    :ssh,                     # 79 - error from the ssh layer somewhat
                                   #   generic so the error message will be of
                                   #   interest when this has happened
    :ssl_shutdown_failed,     # 80 - Failed to shut down the SSL connection
    :again,                   # 81 - socket is not ready for send/recv
                                   #   wait till it's ready and try again (Added in 7.18.2)
    :ssl_crl_badfile,         # 82 - could not load crl file missing or wrong format (Added in 7.19.0)
    :ssl_issuer_error,        # 83 - Issuer check failed.  (Added in 7.19.0)
    :curl_last # never use!
    ]

  attach_function 'curl_global_init', [:long], :int
  attach_function 'curl_easy_init', [], :pointer
  attach_function 'curl_easy_cleanup', [:pointer], :pointer
  attach_function 'curl_easy_perform', [:pointer], :int
  attach_function 'curl_easy_strerror', [:int], :string

  # curl_easy_setopt has different parameter types
  attach_function 'curl_easy_setopt', [:pointer, :int, :pointer], :int
  attach_function 'curl_easy_setopt_long', 'curl_easy_setopt', [:pointer, :int, :long], :int
  # size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp);
  callback :write_data_callback, [:pointer, :int, :int, :pointer], :int
  attach_function 'curl_easy_setopt_write_callback', 'curl_easy_setopt', [:pointer, :int, :write_data_callback], :int

  # typedef int (*curl_progress_callback)(void *clientp, double dltotal, double dlnow, double ultotal, double ulnow);
  callback :progress_callback, [:pointer, :double, :double, :double], :int
  attach_function 'curl_easy_setopt_progress_callback', 'curl_easy_setopt', [:pointer, :int, :progress_callback], :int

  def on_write(&block)
    curl_easy_setopt_write_callback @handle, CURLOPT_WRITEFUNCTION, block
  end

  def on_progress(&block)
    curl_easy_setopt_long @handle, CURLOPT_NOPROGRESS, 0
    curl_easy_setopt_progress_callback @handle, CURLOPT_PROGRESSFUNCTION, block
  end

  def timeout=(value)
    curl_easy_setopt_long @handle, CURLOPT_TIMEOUT, value
  end

  def forbid_reuse!
    curl_easy_setopt_long @handle, CURLOPT_FORBID_REUSE, 1
  end

  def follow_location!
    curl_easy_setopt_long @handle, CURLOPT_FOLLOWLOCATION, 1
  end

  def verbose!
    curl_easy_setopt_long @handle, CURLOPT_VERBOSE, 1
  end

  def url=(url)
    curl_easy_setopt @handle, CURLOPT_URL, url
  end

  def initialize
    result = curl_global_init(0)
    puts "Error initializing libcurl: #{result}" && exit unless result.zero?
    @handle = curl_easy_init
    @error_buffer = ''
    curl_easy_setopt @handle, CURLOPT_ERRORBUFFER, @error_buffer
  end

  def perform
    result = curl_easy_perform(@handle)
    if result != CURLcode[:ok]
      puts curl_easy_strerror(result)
      if @error_buffer != ''
        puts @error_buffer
      end
    end
    curl_easy_cleanup(@handle)
  end

  def self.download(url, filename)
    kurl = new
    kurl.url = url
    kurl.follow_location!
    kurl.forbid_reuse!

    yield kurl if block_given?

    file = File.open(filename, 'w+')
    kurl.on_write do |buffer, size, nmemb, userp| 
      file << buffer.read_string(size * nmemb)
      size * nmemb
    end

    kurl.perform
    file.close
  end
end
