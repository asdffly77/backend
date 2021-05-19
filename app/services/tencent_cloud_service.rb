require 'pycall/import'
include PyCall::Import

# pyfrom 'scalecodec', import: :ScaleBytes
# pyfrom 'scalecodec.base', import: :ScaleDecoder
# pyfrom 'scalecodec.block', import: %i(ExtrinsicsDecoder EventsDecoder)
# pyfrom 'scalecodec.metadata', import: :MetadataDecoder
pyfrom 'tencentcloud.common.credential', import: :Credential
pyfrom 'tencentcloud.live.v20180801.live_client', import: %i(LiveClient)
pyfrom 'tencentcloud.live.v20180801.models', import: %i(DescribeLiveDomainsRequest)
# pyfrom 'tencentcloud.vod.v20180801.vod_client', import: %i(VodClient SearchMedia)
pyfrom 'tencentcloud.vod.v20180717.vod_client', import: %i(VodClient)
pyfrom 'tencentcloud.vod.v20180717.models', import: %i(SearchMediaRequest)
require 'digest'

#TencentCloudService.new('AKIDZrwmMfTQO5UdUtscKnIV9W6i3ngKmqpZ', 'bw3uVRN6ZJM8etsgEm34tE5YdS4RZbQK')
class TencentCloudService
  def initialize(secretId, secretKey)
    @secretId = secretId
    @secretKey = secretKey
  end

  # a.get_live_address('rtmp.morningstar-cloud.com', '11ce3b625f0986a4386574a0c9204faf', 'test', 1590249600)
  def self.get_live_address(domain, key, stream_name, time = nil, template = nil, live_type = nil, stream = 'rtmp')
    template = "_#{template}" if template.present?
    live_type = ".#{live_type}" if live_type.present?
    if key && time
      txtime = time.to_s(16).upcase rescue nil
      secret = Digest::MD5.hexdigest("#{key}#{stream_name}#{template}#{txtime}")
      return "#{stream}://#{domain}/live/#{stream_name}#{template}#{live_type}?txSecret=#{secret}&txTime=#{txtime}"
    else
      return "#{stream}://#{domain}/live/#{stream_name}#{template}#{live_type}"
    end
  end

  def get_live_domains
    cred = ::Credential.new(@secretId, @secretKey)
    # 实例化要请求产品(以cvm为例)的client对象
    client = ::LiveClient.new(cred, "ap-guangzhou")
    # 实例化一个请求对象
    req = ::DescribeLiveDomainsRequest.new
    # 通过client对象调用想要访问的接口，需要传入请求对象
    resp = client.DescribeLiveDomains(req)
    # 输出json格式的字符串回包
    print(resp.to_json_string())
  end

  def get_live_history(stream_name, page = 0, per = 4)
    cred = ::Credential.new(@secretId, @secretKey)
    client = ::VodClient.new(cred, "ap-guangzhou")
    req = SearchMediaRequest.new
    req.StreamId = stream_name
    req.Offset = page * per
    req.Limit = per
    resp = client.SearchMedia(req)
    return JSON.parse(resp.to_json_string())
  end
  
  

  # def get_rpc_methods
  #   response = rpc_call("rpc", [])
  #   response["result"]
  # end
  

  # def get_system_chain
  #   response = rpc_call("system_chain", [])
  #   response["result"]
  # end

  # def get_system_properties
  #   response = rpc_call("system_properties", [])
  #   response["result"]
  # end

  # def get_block_hash(block_id)
  #   response = rpc_call("chain_getBlockHash", [block_id.to_i])
  #   response["result"]
  # end
 
  # def get_chain_block(block_hash: nil, block_id: nil, metadata_decoder: nil)
  #   block_hash ||= get_block_hash(block_id)
  #   response = rpc_call("chain_getBlock", [block_hash])["result"]
  #   p response
  #   metadata_decoder ||= get_block_metadata()
  #   response['block']['extrinsics'].each_with_index do |extrinsic_data, index|
  #     extrinsic_decoder = ExtrinsicsDecoder.new(
  #       data = ScaleBytes.new(extrinsic_data),
  #       metadata: metadata_decoder
  #     )
  #     response['block']['extrinsics'][index] = extrinsic_decoder.decode()
  #   end
  #   response
  # end

  # # def get_block_metadata(self, block_hash, decode=True):
  # #   response = self.__rpc_request("state_getMetadata", [block_hash])

  # #   if response.get('result'):

  # #       if decode:
  # #           metadata_decoder = MetadataDecoder(ScaleBytes(response.get('result')))
  # #           metadata_decoder.decode()

  # #           return metadata_decoder

  # #       return response

  # def get_block_metadata
  #   response = rpc_call("state_getMetadata", [])
  #   metadata_decoder = MetadataDecoder.new(ScaleBytes.new(response['result']))
  #   metadata_decoder.decode()
  #   metadata_decoder    
  # end
  

  # private

  # def rpc_call(name, params)
  #   _request = Typhoeus::Request.new(
  #     @url,
  #     method: :post,
  #     headers: {
  #       'Content-Type': "application/json",
  #       # 'cache-control': "no-cache"
  #     },
  #     body: {
  #       "jsonrpc": "2.0",
  #       "method": name,
  #       "params": params,
  #       "id": Time.now.to_i
  #     }.to_json
  #   )
  #   JSON.parse(_request.run.body)
  # end
end