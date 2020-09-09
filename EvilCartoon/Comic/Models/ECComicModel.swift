//
//  ECComicModel.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/8/31.
//  Copyright © 2020 howhyone. All rights reserved.
//

import HandyJSON

struct ClassifyTagModel: HandyJSON {
    var name: String?
    var argName: String?
    var argVal: Int = 0
}

struct AuthorModel: HandyJSON {
    var id: Int = 0
    var avatar: String?
    var name: String?
}

struct ComicStaticModel: HandyJSON {
    var name: String?
    var commic_id: Int = 0
    var short_description: String?
    var accredit: Int = 0
    var cover: String?
    var is_vip: Int = 0
    var type: Int = 0
    var ori: String?
    var theme_ids: [String]?
    var series_status: Int = 0
    var last_update_time: TimeInterval = 0
    var description: String?
    var cate_id: String?
    var status: Int = 0
    var thread_id: Int = 0
    var last_update_week: String?
    var wideCover: String?
    var classifyTags: [ClassifyTagModel]?
    var is_week: Bool = false
    var comic_color: String?
    var author: AuthorModel?
    var is_dub: Bool = false
}

struct ImHightModel: HandyJSON {
    var height: Int = 0
    var width: Int = 0
}

struct ChapterStaticModel: HandyJSON {
    var chapter_id: Int = 0
    var name: String?
    var image_total: Int = 0
    var type: Int = 0
    var price: String?
    var size: Int32 = 0
    var pass_time: TimeInterval = 0
    var release_time: TimeInterval = 0
    var zip_high_webp: Int = 0
    var is_new: Bool = false
    var has_locked_image: Bool = false
    var imHightArr: [ImHightModel]?
    var countImHightArr: Int = 0
}

struct OtherWorkModel: HandyJSON {
    var comicId: Int = 0
    var coverUrl: String?
    var name: String?
    var passChapterNum: Int = 0
}

struct DetailStaticModel: HandyJSON {
    var comic: ComicStaticModel?
    var chapter_list: [ChapterStaticModel]?
    var otherWorks: [OtherWorkModel]?
    
}

struct ComicRealtimeModel: HandyJSON {
    var comic_id: Int = 0
    var user_id: Int = 0
    var status: Int = 0
    var click_total: String?
    var total_ticket: String?
    var favorite_total: String?
    var gift_total: String?
    var monthly_ticket: String?
    var vip_discount: Double = 0
    var is_vip_free: Bool = false
    var is_free: Bool = false
    var is_vip_buy: Bool = false
    var is_auto_buy: Bool = false
}

struct ChapterRealtimeModel: HandyJSON {
    var vip_images: Int = 0
    var is_view: Bool = false
    var chapter_id: Int = 0
    var buyed: Bool = false
    var buy_price: String?
    var read_state: Int = 0
    var is_free: Bool = false
}

struct DetailRealtimeModel: HandyJSON {
    var comic: ComicRealtimeModel?
    var chapter_list: [ChapterRealtimeModel]?
}
