#
# Cookbook Name:: gpac
# Library:: helpers
#
# Copyright 2012-2014, Escape Studios
#

# GPAC module
module GPAC
  # helpers module
  module Helpers
    # Returns an array of package names that will install GPAC on a node.
    # Package names returned are determined by the platform running this recipe.
    def gpac_packages
      value_for_platform(
        ['ubuntu'] => { 'default' => ['gpac'] },
        'default' => ['gpac']
      )
    end
  end
end

# Chef class
class Chef
  # Recipe class
  class Recipe
    include GPAC::Helpers
  end
end
