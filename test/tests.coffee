WGS84RasterUtil = require('../')
expect = require('expect.js')
rasterHeight = 650
cellSize = 30.769221037525757
bounds =
   "type": "Feature"
   "properties": {}
   "geometry":
      "type": "Polygon"
      "coordinates": [[
         [-122.71082412045891, 37.834057],
         [-122.71082412045891, 38.01372],
         [-122.48306391589622, 38.01372],
         [-122.48306391589622, 37.834057],
         [-122.71082412045891, 37.834057]
      ]]

corner =
   SW: 0
   NW: 1
   NE: 2
   SE: 3

boundsSWCornerPoint = null
boundsNWCornerPoint = null
boundsNECornerPoint = null
rowBounds = null

describe 'WGS84RasterUtil', ->

   beforeEach ->
      boundsSWCornerPoint =
         "type": "Point"
         "coordinates": bounds.geometry.coordinates[0][corner.SW]

      boundsNWCornerPoint =
         "type": "Point"
         "coordinates": bounds.geometry.coordinates[0][corner.NW]

      boundsNECornerPoint =
         "type": "Point"
         "coordinates": bounds.geometry.coordinates[0][corner.NE]

   describe 'cellSize', ->
      it 'should calculate correct cell size', ->
         expect(WGS84RasterUtil.cellSize(boundsNWCornerPoint, boundsSWCornerPoint, rasterHeight)).to.equal(cellSize)

   describe 'rowBounds', ->
      it 'should calculate correct row bounds', ->
         rowBounds = WGS84RasterUtil.rowBounds(boundsNWCornerPoint, boundsNECornerPoint, cellSize, 1)
         expect(rowBounds[corner.SW][0]).to.equal(-122.7108241205)
         expect(rowBounds[corner.SW][1]).to.equal(38.0131671908)
         expect(rowBounds[corner.NW][0]).to.equal(-122.7108241205)
         expect(rowBounds[corner.NW][1]).to.equal(38.0134435954)
         expect(rowBounds[corner.NE][0]).to.equal(-122.4830639159)
         expect(rowBounds[corner.NE][1]).to.equal(38.0134435954)
         expect(rowBounds[corner.SE][0]).to.equal(-122.4830639159)
         expect(rowBounds[corner.SE][1]).to.equal(38.0131671908)

   describe 'cellBounds', ->
      it 'should calculate correct cell bounds', ->
         cellBounds = WGS84RasterUtil.cellBounds({ "coordinates": rowBounds[corner.NW]},
         { "coordinates": rowBounds[corner.SW]}, cellSize, 1)
         expect(cellBounds[corner.SW][0]).to.equal(-122.7104732937)
         expect(cellBounds[corner.SW][1]).to.equal(38.0131671908)
         expect(cellBounds[corner.NW][0]).to.equal(-122.7104732937)
         expect(cellBounds[corner.NW][1]).to.equal(38.0134435954)
         expect(cellBounds[corner.NE][0]).to.equal(-122.7101224669)
         expect(cellBounds[corner.NE][1]).to.equal(38.0134435954)
         expect(cellBounds[corner.SE][0]).to.equal(-122.7101224669)
         expect(cellBounds[corner.SE][1]).to.equal(38.0131671908)
