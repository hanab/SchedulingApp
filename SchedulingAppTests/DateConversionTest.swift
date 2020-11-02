//
//  DateConversionTest.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/31/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import SchedulingApp

class DateConversionTest: XCTestCase {
    
    //MARK: methods
    func testDateIsFormattedCorrectly () {
        let dateString = "2020-10-31T23:30:00Z"
        let date =  dateString.getDateFromString()
        let formattedDate = date?.getFormattedDate() ?? ""
        XCTAssertEqual(formattedDate, "Sat, Oct 31")
    }
}
