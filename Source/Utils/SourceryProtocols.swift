//
//  SourceryProtocols.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 25/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

/* Protocols used as marker protocols for Sourcery */


/// Conform your enum to this marker protocol to make Sourcery generate a `count` + `allCases` static properties
protocol AutoCases {}

/// Conform your types to this marker protocol to make Sourcery generate `Equatable` implementations for you
protocol AutoEquatable {}
