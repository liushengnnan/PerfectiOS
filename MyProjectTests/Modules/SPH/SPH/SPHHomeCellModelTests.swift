//
//  SPHHomeCellModelTests.swift
//  SphDemoTests
//
//  Created by shengnan liu on 16/5/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import SphDemo

class SPHHomeCellModelTests: QuickSpec {
    override func spec() {
        var viewModel: SPHHomeCellModel!
        var yearRecord: YearRecord!
        
        beforeEach {
            var record1 = Record()
            record1.id = 1
            record1.quarter = "2005-Q1"
            record1.volumeOfMobileData = "0.000563"

            var record2 = Record()
            record2.id = 2
            record2.quarter = "2005-Q2"
            record2.volumeOfMobileData = "0.000537"

            var record3 = Record()
            record3.id = 3
            record3.quarter = "2005-Q3"
            record3.volumeOfMobileData = "0.000543"
            let records = [record1, record2, record3]
            yearRecord = YearRecord(records: records, year: "2005")
        }

        afterEach {
            viewModel = nil // Force viewModel to deallocate and stop syncing.
        }
        
        describe("SPHHomeCellModel init Correctly") {
            it("SPHHomeCellModel property") {
                viewModel = SPHHomeCellModel(with: yearRecord)
                let title = try! viewModel.title.asObservable().toBlocking().first()
                let detail = try! viewModel.detail.asObservable().toBlocking().first()
                let hidesDisclosure = try! viewModel.hidesDisclosure.asObservable().toBlocking().first()
                expect(title) == "0.001643"
                expect(detail) == "2005"
                expect(hidesDisclosure) == false
            }
        }
    }
}
