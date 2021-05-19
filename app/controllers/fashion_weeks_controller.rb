class FashionWeeksController < ApplicationController
  def index
    @page_id = 'week'
    @banners = Banner.function_week.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @companies = Company.clothing.allow
    @schedules = {
      :en => [
        {:url => 'https://www.pdconline.org.cn/en/lives?classify=canton_fair', :time => 'Oct 19th 14:00-16:40', :title => 'Canton Fair Fashion Week Best-selling Products Live Show', :tags => ['Women’s Wear', 'Bags', 'Leather Goods', 'Accessories'], :desc => ['Guangzhou Textiles Industry & Trade Holdings Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3vbTxJ', :time => 'Oct 15th 11:00-11:30', :title => 'SATURDAYMODE 2020 Autumn&Winter Collection', :tags => ['Footwear'], :desc => ['SATURDAYMODE ']},
        {:url => 'https://www.pdconline.org.cn/en/lives/L0rTvJ', :time => 'Oct 15th 11:00-11:30', :title => 'JIWENBO Fashion Show', :tags => ['Men’s&Women’s Wear'], :desc => ['JIWENBO']},
        {:url => 'https://www.pdconline.org.cn/en/lives/LWoTEK', :time => 'Oct 15th 11:00-11:30', :title => 'Borderless “Lotus” 95S·Y · Deng Zhaoping  Fashion Show', :tags => ['Men’s&Women’s Wear'], :desc => ['Deng’s Innovational Fashion Design Studio']},
        {:url => 'https://www.pdconline.org.cn/en/lives/LV9Tj4', :time => 'Oct 15th 11:00-11:30', :title => 'The GARYWAT fashion show', :tags => ['Men’s&Women’s Wear'], :desc => ['Guangzhou GARYWAT Haute Couture Design Co., Ltd']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gdWTYe', :time => 'Oct 15th 11:00-11:30', :title => 'Chinese Silk Show by Saint-Joy', :tags => ['Silk Cloth'], :desc => ['Suzhou Saint-Joy Silk Technical Culture Co.,ltd']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3EXT4Q', :time => 'Oct 15th 11:00-11:30', :title => 'Chinese Silk Show by QING JUN PALACE', :tags => ['Silk Cloth'], :desc => ['QING JUN PALACE']},
        {:url => 'https://www.pdconline.org.cn/en/lives/B5eT0p', :time => 'Oct 15th 11:00-11:30', :title => 'Chinese Silk Show by SILIQUE', :tags => ['Silk Cloth'], :desc => ['GUANGDONG SILIQUE GROUP CO.,LTD']},
        {:url => 'https://www.pdconline.org.cn/en/lives/B8vTYe', :time => 'Oct 15th 11:00-11:30', :title => 'Chinese Silk Show by SANGLUO', :tags => ['Silk Cloth'], :desc => ['JIANGSU HUAJIA SILK CORP.,LTD']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3yAT2m', :time => 'Oct 15th 11:00-11:30', :title => 'Beyond Fashion - Yishion & Missio', :tags => ['Women’s wear'], :desc => ['Dongguan Yishion Group Co., LTD.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gpPTYa', :time => 'Oct 15th 11:00-11:30', :title => 'A visual feast of lively fashion apparel', :tags => ['Women’s wear'], :desc => ['Guangzhou Textiles Industry & Trade Holdings Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3rjTkD', :time => 'Oct 15th 11:00-11:30', :title => 'A tribute to heros', :tags => ['Women’s wear'], :desc => ['Guangzhou Textiles Industry & Trade Holdings Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/BRKTnj', :time => 'Oct 15th 11:00-11:30', :title => 'Health and environmental protection, establishing business with quality, integrity-based', :tags => ['Women’s wear'], :desc => ['Guangzhou Textiles Industry & Trade Holdings Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/g1yT6G', :time => 'Oct 15th 11:00-11:30', :title => 'Release of Newcom', :tags => ['Bags & Luggage'], :desc => ['Zhejiang Baomate  Intelligent Equipment Co., Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gzZT9n', :time => 'Oct 15th 11:00-11:30', :title => '"Urban Fashion" -The“Zhejiang Made”Boutique Show of Premium Zhejiang Export Brands in 2020 Canton Fair Fashion Week (Autumn）', :tags => ['Women’s wear'], :desc => ['JIAXING LAYO IMP.&EXP. GROUP CO., LTD.', 'SHAOXING NEWLEAF FOREIGN TRADE CO.,LTD', 'ZHEJIANG ZHONGDA GROUP INTERNATIONAL TRADING CO.,LTD', 'ZHEJIANG JIAXIN SILK CORP.,LTD.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/goXTKy', :time => 'Oct 15th 11:00-11:30', :title => '"Craftsmanship" - The“Zhejiang Made”Boutique Show of Premium Zhejiang Export Brands in 2020 Canton Fair Fashion Week (Autumn）', :tags => ['Women’s wear & reflective apparel'], :desc => ['Zhejiang Trimax International Group', 'ZHEJIANG NATIVE PRODUCE & ANIMAL BY-PRODUCTS I/E GROUP CO., LTD.', 'Zhejiang YGM Technology Co., Ltd', 'ZHEJIANG ORANGE D’OR GARMENTS CO.,LTD']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gM7TMo', :time => 'Oct 15th 11:00-11:30', :title => '"Brilliant Life" - The“Zhejiang Made”Boutique Show of Premium Zhejiang Export Brands in 2020 Canton Fair Fashion Week (Autumn）', :tags => ['Bags&luaggage', 'Toys', 'Women’s wear', 'umbrella'], :desc => ['NEWCOMER GROUP CO.,LTD.', 'Winsun Imp. & Exp. Group Co., Ltd.-Women’s wear', 'Winsun Imp. & Exp. Group Co., Ltd.-Toys', 'Zhejiang Tengxin Umbrella Co.,LTD.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3bvTzw', :time => 'Oct 15th 11:00-11:30', :title => 'Long·Fly brightly', :tags => ['Home Wear(Men & Women)'], :desc => ['Suzhou Long Textile CO.,LTD']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gNGTeo', :time => 'Oct 15th 11:00-11:30', :title => 'Home Textile Fabrics Show', :tags => ['Cushion', 'sofa fabrics', 'curtains'], :desc => ['SYNTEKS']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3kRTwY', :time => 'Oct 15th 11:00-11:30', :title => 'Carpo New Product Release', :tags => ['Women’s wear'], :desc => ['Carpo Co., Ltd']},
        {:url => 'https://www.pdconline.org.cn/en/lives/Ll4Tkd', :time => 'Oct 15th 11:00-11:30', :title => 'Crazy Animal City', :tags => ['Pajamas', 'cartoon jumpsuits'], :desc => ['Suzhou Wilen Import And Export Co.,LTD']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3DwTQN', :time => 'Oct 15th 11:00-11:30', :title => 'Young, Fashionable, Cool, Sporty, Outdoor', :tags => ['Bags & Luggage '], :desc => ['Pretty Arts Products Company']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gmnTpq', :time => 'Oct 15th 11:00-11:30', :title => 'Hua Kai Yan Ran', :tags => ['Women’s wear'], :desc => ['Changshu Bofan Knitting&Textile Co.,Ltd']},
        {:url => 'https://www.pdconline.org.cn/en/lives/B6OTVM', :time => 'Oct 15th 11:00-11:30', :title => 'Changshu Shicheng Weaving New Product Release', :tags => ['Pajamas', 'home textiles', 'clothing'], :desc => ['Changshu Shicheng Weaving Co.,Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3jpTRZ', :time => 'Oct 15th 11:00-11:30', :title => 'Suzhou XingYing New Product Release', :tags => ['Men’s wear'], :desc => ['Suzhou XingYing Cloth Co.,Ltd']},
        {:url => 'https://www.pdconline.org.cn/en/lives/g22TaO', :time => 'Oct 15th 11:00-11:30', :title => 'CSD New Product Release', :tags => ['Women’s wear'], :desc => ['Changshu Garments Town of China', 'Guangzhou Exhibition Center (CSD)']},
        {:url => 'https://www.pdconline.org.cn/en/lives/37qTKb', :time => 'Oct 15th 11:00-11:30', :title => 'Yuzhirui Knitting New Product Release', :tags => ['Home textiles'], :desc => ['Suzhou Yuzhirui Knitting Co.,Ltd.']},
        {:url => 'https://www.pdconline.org.cn/en/lives/3eVTD7', :time => 'Oct 15th 11:00-11:30', :title => 'Calvelex Women’s Wear Catwalk@Clouds-Portugal by AECLC', :tags => ['Women’s wear'], :desc => ['CALVELEX', 'FRENKEN', 'Helen M cALINDEN']},
        {:url => 'https://www.pdconline.org.cn/en/lives/LOATMv', :time => 'Oct 15th 11:00-11:30', :title => 'KYAIA Footwear Catwalk@Clouds-Portugal by AECLC', :tags => ['Footwear'], :desc => ['FLY LONDON', 'softinos', 'ASPORTUGUESAS']},
        {:url => 'https://www.pdconline.org.cn/en/lives/gq1TDl', :time => 'Oct 15th 11:00-11:30', :title => 'LUIS ONOFRE shoes & accessories Catwalk@Clouds-Portugal by AECLC', :tags => ['Footwear'], :desc => ['Luis Onofre']}
      ],
      :cn => [
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives?classify=canton_fair', :time => '10月19日 14:00-16:40', :title => '广交会时尚周系列活动·时尚爆款Live秀', :tags => ['女装', '箱包', '皮具', '服饰'], :desc => ['广州纺织工贸企业集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3vbTxJ', :time => '10月15日 11:00-11:30', :title => 'SATURDAYMODE 2020秋冬系列', :tags => ['鞋类'], :desc => ['SATURDAYMODE']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/L0rTvJ', :time => '10月15日 11:00-11:30', :title => 'JIWENBO发布会', :tags => ['男女装'], :desc => ['JIWENBO']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/LWoTEK', :time => '10月15日 11:00-11:30', :title => '无界-九五丝域 邓兆萍发布会', :tags => ['男女装'], :desc => ['邓兆萍时尚设计创新工作室']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/LV9Tj4', :time => '10月15日 11:00-11:30', :title => 'GaryWat发布会', :tags => ['男女装'], :desc => ['汀南服饰设计有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gdWTYe', :time => '10月15日 11:00-11:30', :title => '中国丝绸·上久楷', :tags => ['丝绸服装'], :desc => ['苏州上久楷丝绸科技文化有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3EXT4Q', :time => '10月15日 11:00-11:30', :title => '中国丝绸·清君华服', :tags => ['丝绸服装'], :desc => ['清君华服']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/B8vTYe', :time => '10月15日 11:00-11:30', :title => '中国丝绸·桑罗', :tags => ['丝绸服装'], :desc => ['江苏华佳丝绸股份有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/B5eT0p', :time => '10月15日 11:00-11:30', :title => '中国丝绸·丝丽', :tags => ['丝绸服装'], :desc => ['广东省丝丽集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3yAT2m', :time => '10月15日 11:00-11:30', :title => '超越时尚-Yishion & Missio', :tags => ['女装'], :desc => ['东莞市以纯集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gpPTYa', :time => '10月15日 11:00-11:30', :title => '"衣"番声色', :tags => ['女装'], :desc => ['广州纺织工贸企业集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3rjTkD', :time => '10月15日 11:00-11:30', :title => '"疫"情别恋', :tags => ['女装'], :desc => ['广州纺织工贸企业集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/BRKTnj', :time => '10月15日 11:00-11:30', :title => '健康环保，柔软舒适，以质立业，诚信为本', :tags => ['女装'], :desc => ['广州纺织工贸企业集团有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/g1yT6G', :time => '10月15日 11:00-11:30', :title => '悠客新品发布会', :tags => ['箱包'], :desc => ['平湖相伴宝产业互联网有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gzZT9n', :time => '10月15日 11:00-11:30', :title => '2020广交会时尚周（秋季）“品质浙货”浙江出口名牌企业精品走秀（都市风尚）', :tags => ['女装'], :desc => ['嘉兴良友进出口集团股份有限公司', '绍兴市新叶对外贸易有限公司', '浙江中大集团国际贸易有限公司', '浙江嘉欣丝绸股份有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/goXTKy', :time => '10月15日 11:00-11:30', :title => '2020广交会时尚周（秋季）“品质浙货”浙江出口名牌企业精品走秀（匠心织造）', :tags => ['女装', '夜光衣'], :desc => ['浙江全美服装科技集团有限公司', '浙江省土产畜产进出口集团有限公司', '浙江夜光明光电科技股份有限公司', '浙江迪亚服饰有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gM7TMo', :time => '10月15日 11:00-11:30', :title => '2020广交会时尚周（秋季）“品质浙货”浙江出口名牌企业精品走秀（美好生活）', :tags => ['箱包、玩具、女装、伞'], :desc => ['新秀集团有限公司', '汇信进出口集团股份有限公司', '浙江腾鑫伞业有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3bvTzw', :time => '10月15日 11:00-11:30', :title => '朗•行飞扬', :tags => ['睡衣'], :desc => ['苏州朗纺进出口有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gNGTeo', :time => '10月15日 11:00-11:30', :title => '家纺面料秀', :tags => ['抱枕', '沙发面料', '窗帘'], :desc => ['苏州至尚天禾纺织有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3kRTwY', :time => '10月15日 11:00-11:30', :title => '嘉轩行服装展示', :tags => ['女装'], :desc => ['苏州嘉轩行进出口贸易有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/Ll4Tkd', :time => '10月15日 11:00-11:30', :title => '疯狂动物城                                ', :tags => ['睡衣', '睡袍', '卡通连体衣'], :desc => ['常熟威伦贸易有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3DwTQN', :time => '10月15日 11:00-11:30', :title => '年轻 时尚，玩酷，运动，户外', :tags => ['箱包'], :desc => ['常熟市钟意工艺品有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gmnTpq', :time => '10月15日 11:00-11:30', :title => '花开嫣然', :tags => ['时装'], :desc => ['常熟市博凡针纺织有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/B6OTVM', :time => '10月15日 11:00-11:30', :title => '世诚织造服装&家纺产品展示', :tags => ['睡衣、家纺、服装'], :desc => ['常熟市世诚织造有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3jpTRZ', :time => '10月15日 11:00-11:30', :title => '苏州行鹰男装展示', :tags => ['男装'], :desc => ['苏州市行鹰服饰有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/g22TaO', :time => '10月15日 11:00-11:30', :title => '常熟服装城广州展销中心CSD服装展示', :tags => ['服装'], :desc => ['常熟服装城广州展销中心 CSD']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/37qTKb', :time => '10月15日 11:00-11:30', :title => '宇之瑞家纺产品展示', :tags => ['家纺'], :desc => ['苏州市宇之瑞针织有限公司']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/3eVTD7', :time => '10月15日 11:00-11:30', :title => '葡华企业家联会主推葡萄牙女装品牌秀', :tags => ['女装'], :desc => ['CALVELEX', 'FRENKEN', 'Helen M cALINDEN']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/LOATMv', :time => '10月15日 11:00-11:30', :title => '葡华企业家联会主推葡萄牙鞋类品牌秀', :tags => ['鞋类'], :desc => ['FLY LONDON', 'softinos', 'ASPORTUGUESAS']},
        {:url => 'https://www.pdconline.org.cn/zh-CN/lives/gq1TDl', :time => '10月15日 11:00-11:30', :title => '路易.盎范鞋类及饰品设计秀', :tags => ['鞋类'], :desc => ['路易.盎范']}
      ]
    }
  end
end

