require 'rack'
require 'rack/json_body_parser'
require 'router'
require 'dependency'
require 'messaging/postgres'
require 'settings'
require 'clock'
require 'identifier/uuid'

require 'registration/client'

require 'registration/resource/settings'

require 'registration/resource/command/expose_headers'
require 'registration/resource/command/session'
require 'registration/resource/command/register'
require 'registration/resource/command'

require 'registration/resource/query'

require 'registration/resource/application'
require 'registration/resource/middleware'
