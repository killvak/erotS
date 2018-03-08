//
//  FilterCustomeView.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol  FilterProtocol : class  {
    func dismissView()
    func applyFilterHandler()
}

class FilterCustomeView: UIView , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var emptyViewBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate : FilterProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
    
    
    private func commonUnit() {
        
        let view = Bundle.main.loadNibNamed("FilterCustomeView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 46
        tableView.register(UINib(nibName: "FilterMainCell", bundle: nil), forCellReuseIdentifier: "FilterMainCell")

    }
    @IBAction func dismissHandler(_ sender: UIButton) {
        self.delegate?.dismissView()
    }
    
    @IBAction func applyFilterHandler(_ sender: UIButton) {
        self.delegate?.applyFilterHandler()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterMainCell", for: indexPath) as! FilterMainCell
            cell.setupContainerView(viewType: indexPath.row)
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil 
    }
}

extension FilterCustomeView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1
 
            guard let cell = tableView.cellForRow(at: indexPath) as? FilterMainCell else { return }
          
            cell.selecteds()
            // 4
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // 5
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
     
    }
}
