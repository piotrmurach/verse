# Change log

## [v0.5.0] - 2016-10-25

### Added
* Add ParseError to Padder

### Changed
* Change Sanitizer to module
* Replaces UnicodeUtils.display_width with Unicode::DisplayWidth.of by @MichaelBaker

## [v0.4.0] - 2015-03-28

### Added
* Add Sanitizer#ansi? to check for ANSI codes

### Changed
* Change Alignment to work with ANSI codes
* Change Truncation to work with ANSI codes
* Change Wrapping to work with ANSI codes
* Chnage Padding to work with ANSI codes

## [v0.3.0] - 2015-02-28

### Added
* Add Sanitizer#replace for substitutiong linebreaks
* Add Padder for parsing padding values
* Add Padding for padding content around

### Changed
* Change Wrapping#wrap to preserve whitespace characters

## [v0.2.1] - 2015-02-15

### Fixed
* Fix empty string alignment
* Fix alignment to stop modifying original content

## [v0.2.0] - 2015-02-15

### Added
* Add unicode support

### Changed
* Change wrap, truncate and align to work with unicode characters

### Removed
* Remove padding and indent from Verse::Wrapping

## [v0.1.0] - 2015-02-07

* Inital implementation and release

[v0.5.0]: https://github.com/piotrmurach/verse/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/piotrmurach/verse/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/piotrmurach/verse/compare/v0.2.1...v0.3.0
[v0.2.1]: https://github.com/piotrmurach/verse/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/piotrmurach/verse/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/piotrmurach/verse/compare/v0.1.0
