# namespace :db do
#   task seed: :environment do
#     seeds = YAML::load_file(Rails.root.join('db', 'seeds.yml'))[ENV['RACK_ENV']]
#     if seeds.present?
#       seeds.keys.each do |key|
#         klass_name = key.camelize.singularize
#         if Object.const_defined?(klass_name)
#           klass = Object.const_get klass_name
#           seeds[key].each do |seed|
#             klass_object = klass.new
#             klass_object.attributes = seed['attributes']
#             if seed['associations'].present?
#               seed['associations'].keys.each do |association_key|
#                 reflection = klass.reflect_on_association(association_key)
#                 if Object.const_defined?(reflection.class_name)
#                   # p reflection.class_name
#                 else
#                   # Seems like polymorphic
#                   # Then we have to look for key['class_name'] and key['index']
#                   association_klass_name = seed['associations'][association_key]['class_name']
#                   if association_klass_name.present? && Object.const_defined?(association_klass_name)
#                     # p association_klass_name
#                     # association_db_id = seeds[seed['associations'][association_key]['class_name'].underscore.pluralize][seed['associations'][association_key]['index']]['db_id']
#                   end
#                 end
#               end
#             end
#             seed['db_id'] = Random.new.rand(1...42)
#           end
#         else
#           puts "#{klass_name} class is not defined"
#         end
#       end
#     end
#     p seeds
#   end
# end