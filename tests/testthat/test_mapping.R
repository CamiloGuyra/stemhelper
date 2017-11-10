context("Mapping functions")

test_that("stemhelper calc_full_extent", {
  library(sp)

  root_path <- "~/Box Sync/Projects/2015_stem_hwf/documentation/data-raw/"
  species <- "woothr-ERD2016-PROD-20170505-3f880822"
  sp_path <- paste(root_path, species, sep = "")

  abund <- stack_stem(sp_path, variable = "abundance_umean")

  # expected RasterStack
  expect_is(calc_full_extent(abund), "Extent")

  # RasterLayer
  expect_is(calc_full_extent(abund[[26]]), "Extent")

  # projected
  abund_prj <- raster::projectRaster(abund[[26]], crs = "+init=epsg:4326")
  expect_is(abund_prj, "Extent")

  # not a raster object
  ext_poly <- methods::as(raster::extent(abund), "SpatialPolygons")
  raster::crs(ext_poly) <- raster::crs(abund)
  expect_error(calc_full_extent(ext_poly))
})