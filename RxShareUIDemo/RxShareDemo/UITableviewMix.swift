//
//  UITableviewMix.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/8.
//  Copyright © 2019 FY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class UITableviewMix: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据
        let sections = Observable.just([
            MySection(header: "我是第一个分区", items: [
                .TitleImageSectionItem(title: "图片数据1", image: UIImage(named: "php")!),
                .TitleImageSectionItem(title: "图片数据2", image: UIImage(named: "react")!),
                .TitleSwitchSectionItem(title: "开关数据1", enabled: true)
                ]),
            MySection(header: "我是第二个分区", items: [
                .TitleSwitchSectionItem(title: "开关数据2", enabled: false),
                .TitleSwitchSectionItem(title: "开关数据3", enabled: false),
                .TitleImageSectionItem(title: "图片数据3", image: UIImage(named: "swift")!)
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            //设置单元格
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath] {
                case let .TitleImageSectionItem(title, image):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "titleImageCell",
                                                             for: indexPath)
                    (cell.viewWithTag(1) as! UILabel).text = title
                    (cell.viewWithTag(2) as! UIImageView).image = image
                    return cell
                    
                case let .TitleSwitchSectionItem(title, enabled):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "titleSwitchCell",
                                                             for: indexPath)
                    (cell.viewWithTag(1) as! UILabel).text = title
                    (cell.viewWithTag(2) as! UISwitch).isOn = enabled
                    return cell
                }
        },
            //设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        }
        )
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

//单元格类型
enum SectionItem {
    case TitleImageSectionItem(title: String, image: UIImage)
    case TitleSwitchSectionItem(title: String, enabled: Bool)
}

//自定义Section
struct MySection {
    var header: String
    var items: [SectionItem]
}

extension MySection : SectionModelType {
    typealias Item = SectionItem
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
