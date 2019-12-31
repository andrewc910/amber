require "../version"
require "cli"
require "./recipes/recipe"
require "./config"
require "./commands/command"
require "./commands/*"

module Amber::CLI
  include Amber::Environment
  AMBER_YML = ".opal.yml"

  def self.toggle_colors(on_off)
    Colorize.enabled = !on_off
  end

  class MainCommand < ::Cli::Supercommand
    command_name "opal"
    version "Opal CLI (opalframework.org) - v#{VERSION}"

    class Help
      title "\nOpal CLI"
      header <<-EOS
        The `opal new` command creates a new Opal application with a default
        directory structure and configuration at the path you specify.

        You can specify extra command-line arguments to be used every time
        `opal new` runs in the .opal.yml configuration file in your project
        root directory

        Note that the arguments specified in the .opal.yml file does not affect the
        defaults values shown above in this help message.

        Usage:
        opal new [app_name] -d [sqlite | mysql | pg] -t [ecr | pg] --no-deps
      EOS

      footer <<-EOS
      Example:
        opal new ~/Code/Projects/weblog
        This generates a skeletal Opal installation in ~/Code/Projects/weblog.
      EOS
    end

    class Options
      version desc: "prints Opal version"
      help desc: "describe available commands and usages"
      string ["-t", "--template"], desc: "preconfigure for selected template engine", any_of: %w(ecr slang), default: "ecr"
      string ["-d", "--database"], desc: "preconfigure for selected database.", any_of: %w(sqlite mysql pg), default: "sqlite"
      string ["-r", "--recipe"], desc: "use a named recipe. See documentation at https://docs.opalframework.org/opal/cli/recipes.", default: nil
    end
  end
end
