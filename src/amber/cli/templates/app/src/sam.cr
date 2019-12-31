# src/sam.cr
require "jennifer"
require "../config/database"

require "../config/jennifer"
require "../db/migrations/*"
require "sam"
require "jennifer/sam"
load_dependencies "jennifer"
Sam.help
