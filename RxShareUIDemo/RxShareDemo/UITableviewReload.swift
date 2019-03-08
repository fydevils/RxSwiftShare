//
//  UITableviewReload.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/8.
//  Copyright © 2019 FY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class UITableviewReload: BaseVC {
    //刷新按钮
    var refreshButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!

    //表格
    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    //搜索栏
    var searchBar:UISearchBar!
    
    
    @objc func imageBarButtonItemMethod() -> Void {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         */
        refreshButton = UIBarButtonItem.init(title: "刷新", style: .plain, target: self, action: #selector(imageBarButtonItemMethod))
        cancelButton = UIBarButtonItem.init(title: "停止", style: .plain, target: self, action: #selector(imageBarButtonItemMethod))

        self.navigationItem.setRightBarButtonItems([refreshButton,cancelButton], animated: true)
        
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建表头的搜索栏
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.bounds.size.width, height: 56))
        self.tableView.tableHeaderView =  self.searchBar
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
//        flatMapLatest 的作用是当在短时间内（上一个请求还没回来）连续点击多次“刷新”按钮，虽然仍会发起多次请求，但表格只会接收并显示最后一次请求。避免表格出现连续刷新的现象。
            .flatMapLatest{
//                      该功能简单说就是通过 takeUntil 操作符实现。当 takeUntil 中的 Observable 发送一个值时，便会结束对应的 Observable。
                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
            }
            .flatMap(filterResult) //筛选数据
            .share(replay: 5)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
    
    //过滤数据
    func filterResult(data:[SectionModel<String, Int>])
        -> Observable<[SectionModel<String, Int>]> {
            return self.searchBar.rx.text.orEmpty
                //.debounce(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5秒才发送
                .flatMapLatest{
                    query -> Observable<[SectionModel<String, Int>]> in
                    print("正在筛选数据（条件为：\(query)）")
                    //输入条件为空，则直接返回原始数据
                    if query.isEmpty{
                        return Observable.just(data)
                    }
                        //输入条件为不空，则只返回包含有该文字的数据
                    else{
                        var newData:[SectionModel<String, Int>] = []
                        for sectionModel in data {
                            let items = sectionModel.items.filter{ "\($0)".contains(query) }
                            newData.append(SectionModel(model: sectionModel.model, items: items))
                        }
                        return Observable.just(newData)
                    }
            }
    }
}

/*
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
