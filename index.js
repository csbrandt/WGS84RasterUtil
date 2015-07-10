/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */


var WGS84Util = require('wgs84-util');

/** @module wgs84-raster-util */
var WGS84RasterUtil = exports;

WGS84RasterUtil.cellSize = function(NWRowCornerCoord, SWRowCornerCoord, rasterHeight) {
   return WGS84Util.distanceBetween(SWRowCornerCoord, NWRowCornerCoord) / rasterHeight;
};

WGS84RasterUtil.rowBounds = function(NWRowCornerCoord, NERowCornerCoord, cellSize, rowIndex) {
   var rowBounds = [];
   var rowNWCornerLatLng = WGS84Util.destinationPoint(NWRowCornerCoord, 180, rowIndex * cellSize);
   var rowNECornerLatLng = WGS84Util.destinationPoint(NERowCornerCoord, 180, rowIndex * cellSize);

   var NW = rowNWCornerLatLng.coordinates;
   var NE = rowNECornerLatLng.coordinates;
   var SE = WGS84Util.destinationPoint({
      "coordinates": NE
   }, 180, cellSize).coordinates;
   var SW = WGS84Util.destinationPoint({
      "coordinates": NW
   }, 180, cellSize).coordinates;

   rowBounds.push(SW, NW, NE, SE, SW);

   return rowBounds;
};

WGS84RasterUtil.cellBounds = function(NWRowCornerCoord, SWRowCornerCoord, cellSize, colIndex) {
   var cellBounds = [];

   var NW = [WGS84Util.destinationPoint(NWRowCornerCoord, 90, colIndex * cellSize).coordinates[0],
   NWRowCornerCoord.coordinates[1]];
   var NE = [WGS84Util.destinationPoint({
      "coordinates": NW
   }, 90, cellSize).coordinates[0], NW[1]];
   var SE = [NE[0], SWRowCornerCoord.coordinates[1]];
   var SW = [NW[0], SWRowCornerCoord.coordinates[1]];

   cellBounds.push(SW, NW, NE, SE, SW);

   return cellBounds;
};
