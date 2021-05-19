class DesignActivitiesController < ApplicationController
  def index
    @page_id = 'event'
    @banners = Banner.activity.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @schedules = {
      :cn => [
        {:time => '10月15日9：00', :title => '深耕市场三十年，希腊设计师告诉你趋势预测有多重要', :tags => ['希腊设计师 Olga Sismanido'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/goXTAy'},
        {:time => '10月15日9：00', :title => '基础研究引爆工业设计', :tags => ['石振宇', '汤重熹'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/gM7Tro'},
        {:time => '10月15日9：00', :title => '用设计助力企业塑造全球化品牌', :tags => ['赵壁'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3rjTjD'},
        {:time => '10月15日9：00', :title => '设计构建美好生活', :tags => ['李琦'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3yATnm'},
        {:time => '10月15日9：00', :title => '修心，感受生活中的美好', :tags => ['费勇'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/gzZT6n'},
        {:time => '10月16日10：00', :title => '国内品牌策略和设计的再爆发', :tags => ['赵伯恒'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/gmnTn5'},
        {:time => '10月19日16：00-17：00', :title => '始于爆品 忠于品牌', :tags => ['周立钢'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3bvTRO'},
        {:time => '10月20日16：00-17：00', :title => '线上设计新形式，全新品牌解决方案，打造中国自主品牌新势力', :tags => ['邹碧翠'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3ARTOE'},
        {:time => '10月21日16：00-17：00', :title => '产品价值，增量创新', :tags => ['晋常宝'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/gNGT40'},
        {:time => '10月15日9：00', :title => '如何让中国传统工艺走向世界？我们得向这个品牌学习', :tags => ['77°全球家居新媒体 ZANAT品牌专访'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/g22TAO'},
        {:time => '10月15日9：00', :title => '超越竞争的设计战略', :tags => ['赵璧'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3kRT2Y'},
        {:time => '10月15日9：00', :title => '设计不停步 转型正当时', :tags => ['曹小琴', '赵璧 ', '周鹏 ', '殷浩'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/LYMTbX'},
        {:time => '10月15日9：00', :title => '从1到4，赋能产品创新价值链', :tags => ['晋常宝', '王培'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/3eVTb7'},
        {:time => '10月15日9：00', :title => '因我而变，如何打造超级单品', :tags => ['李琦'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/LOATmv'},
        {:time => '10月15日9：00', :title => '超级设计引爆商业未来', :tags => ['李琦', '吴展', '郭娴'], :url => 'https://www.pdconline.org.cn/zh-CN/lives/gq1Tdl'}

      ],
      :en => [
        {:time => '9:00 Oct 15', :title => 'PDC 10th Anniversary Celebrities‘ Interview -Olga', :tags => ['Olga Sismanido'], :url => 'https://www.pdconline.org.cn/en/lives/goXTAy'},
        {:time => '9:00 Oct 15', :title => 'PDC 10th Anniversary Celebrities‘ Interview -Prof. Tang & Prof. Shi', :tags => ['Shi Zhenyu,Tang Chongxi'], :url => 'https://www.pdconline.org.cn/en/lives/gM7Tro'},
        {:time => '9:00 Oct 15', :title => 'PDC 10th Anniversary Celebrities‘ Interview -Bill Zhao', :tags => ['Bill Zhao'], :url => 'https://www.pdconline.org.cn/en/lives/3rjTjD'},
        {:time => '9:00 Oct 15', :title => 'PDC 10th Anniversary Celebrities‘ Interview -Li Qi', :tags => ['Li Qi'], :url => 'https://www.pdconline.org.cn/en/lives/3yATnm'},
        {:time => '9:00 Oct 15', :title => 'PDC 10th Anniversary Celebrities‘ Interview -Fei Yong', :tags => ['Fei Yong'], :url => 'https://www.pdconline.org.cn/en/lives/gzZT6n'},
        {:time => '10:00 Oct 16', :title => 'The Re-emergence of the Domestic Brand Strategy and Design', :tags => ['Flanders Zhao'], :url => 'https://www.pdconline.org.cn/en/lives/gmnTn5'},
        {:time => '16：00-17：00 Oct 19', :title => 'Start With Explosive,Loyal to The Brand', :tags => ['Zhou Ligang_x005f'], :url => 'https://www.pdconline.org.cn/en/lives/3bvTRO'},
        {:time => '16：00-17：00 Oct 20', :title => 'New Design Method: Online Branding Solution ', :tags => ['Becky Zhou'], :url => 'https://www.pdconline.org.cn/en/lives/3ARTOE'},
        {:time => '16：00-17：00 Oct 21', :title => 'Product Value, for The Incremental Innovation', :tags => ['Jin Changbao'], :url => 'https://www.pdconline.org.cn/en/lives/gNGT40'},
        {:time => '9:00 Oct 15', :title => 'ZANAT Brand Interview of the global home furnishings new media of 77°', :tags => ['ZANAT Brand'], :url => 'https://www.pdconline.org.cn/en/lives/g22TAO'},
        {:time => '9:00 Oct 15', :title => 'Gaining a Competitive Advantage through Design Strategy', :tags => ['Bill Zhao'], :url => 'https://www.pdconline.org.cn/en/lives/3kRT2Y'},
        {:time => '9:00 Oct 15', :title => 'The Design Keeps on Going, the Transformation just in Time', :tags => ['Xiaoqin Cao', 'Bill Zhao', 'Jerome Zhou', 'Spawn Yin'], :url => 'https://www.pdconline.org.cn/en/lives/LYMTbX'},
        {:time => '9:00 Oct 15', :title => 'From One to Four, to Energize the Value Chain of Product Innovation', :tags => ['Jin Changbao', 'Wang Pei'], :url => 'https://www.pdconline.org.cn/en/lives/3eVTb7'},
        {:time => '9:00 Oct 15', :title => 'Change Because of “Me”，How to Create Super Product', :tags => ['Li Qi'], :url => 'https://www.pdconline.org.cn/en/lives/LOATmv'},
        {:time => '9:00 Oct 15', :title => 'Super Design Drives the Future of Business', :tags => ['Li Qi', 'Wu Zhan', 'Guo Xian'], :url => 'https://www.pdconline.org.cn/en/lives/gq1Tdl'}
      ]
    }
  end
  
end
