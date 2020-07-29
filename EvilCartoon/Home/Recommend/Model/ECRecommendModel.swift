//
//  ECRecommendModel.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/21.
//  Copyright © 2020 howhyone. All rights reserved.
//

import HandyJSON

struct ECRecommendModel: HandyJSON {
    var galleryItems: [GalleryItemModel]?
    var textItems: [TextItemModel]?
    var comicLists: [ComicListModel]?
    var editTime: TimeInterval = 0
}
struct GalleryItemModel: HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [ExtModel]?
    var title: String?
    var content: String?
}

struct TextItemModel: HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [ExtModel]?
    var title: String?
    var content: String?
}

struct ComicListModel: HandyJSON {
    var comicType: UComicType = .none
    var canedit: Bool = false
    var sortId: Int = 0
    var titleIconUrl: String?
    var newTitleIconUrl: String?
    var description: String?
    var itemTitle: String?
    var argCon: Int = 0
    var argName: String?
    var argValue: Int = 0
    var argType: Int = 0
    var comics:[ComicModel]?
    var maxSize: Int = 0
    var canMore: Bool = false
    var hasMore: Bool = false
    var spinnerList: [SpinnerModel]?
    var defaultParameters: DefaultParametersModel?
    var page: Int = 0
}

struct ComicModel: HandyJSON {
    var comicId: Int = 0
    var comic_id: Int = 0
    var cate_id: Int = 0
    var name: String?
    var title: String?
    var itemTitle: String?
    var subTitle: String?
    var author_name: String?
    var author: String?
    var cover: String?
    var wideCover: String?
    var content: String?
    var description: String?
    var short_description: String?
    var affiche: String?
    var tag: String?
    var tags: [String]?
    var group_ids: String?
    var theme_ids: String?
    var url: String?
    var read_order: Int = 0
    var create_time: TimeInterval = 0
    var last_update_time: TimeInterval = 0
    var deadLine: TimeInterval = 0
    var new_comic: Bool = false
    var chapter_count: Int = 0
    var cornerInfo: Int = 0
    var linkType: Int = 0
    var specialId: Int = 0
    var specialType: Int = 0
    var argName: String?
    var argValue: Int = 0
    var argCon: Int = 0
    var flag: Int = 0
    var conTag: Int = 0
    var isComment: Bool = false
    var is_vip: Bool = false
    var isExpired: Bool = false
    var canToolBarShare: Bool = false
    var ext: [ExtModel]?
}

struct SpinnerModel: HandyJSON {
    var argCon: Int = 0
    var name: String?
    var conTag: String?
    
}

struct DefaultParametersModel: HandyJSON {
    var defaultSelection: Int = 0
    var defaultArgCon: Int = 0
    var defaultConTagType: String?
}

struct ExtModel: HandyJSON {
    var key: String?
    var val: String?
}

enum UComicType: Int, HandyJSONEnum {
    case none = 0
    case update = 3
    case thematic = 5
    case animation = 9
    case billboard = 11
}
