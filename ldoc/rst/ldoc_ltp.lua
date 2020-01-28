return [==[
# -------- contents of project ----------
# local this_mod = module and module.name
# local no_spaces = ldoc.no_spaces
# local display_name = ldoc.display_name
# local iter = ldoc.modules.iter
# local indent = ldoc.indent
# local function M(txt,item) return ldoc.markup(txt,item,ldoc.plain) end
# local function trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end
# local function rem_newlines(s) return s:gsub("[\r\n]", "") end
# local nowrap = ldoc.wrap and '' or 'nowrap'
# if ldoc.body then -- verbatim HTML as contents; 'non-code' entries
.. _$(module.name):

$(ldoc.body)
# elseif module then -- module documentation
.. _$(module.name):

===============================================================================
$(ldoc.module_typename(module)) *$(module.name)*
===============================================================================

$(M(module.summary,module))
$(M(module.description,module))
# if module.tags.include then
$(M(ldoc.include_file(module.tags.include)))
# end
# if module.see then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
See also:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#   for see in iter(module.see) do
- $(ldoc.href(see)) $(see.label)
#   end -- for

# end -- if see
# if module.usage then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Usage:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: lua

#   for usage in iter(module.usage) do
    $(indent(usage))
#   end -- for

# end -- if usage
# if module.info then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Info:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#   for tag, value in module.info:iter() do
- **$(tag)**: $(M(value,module))
#   end

# end -- if module.info

# --- currently works for both Functions and Tables. The params field either contains
# --- function parameters or table fields.
# local show_return = not ldoc.no_return_or_parms
# local show_parms = show_return
# for kind, items in module.kinds() do
#   local kitem = module.kinds:get_item(kind)
#   local has_description = kitem and ldoc.descript(kitem) ~= ""
-------------------------------------------------------------------------------
$(kind)
-------------------------------------------------------------------------------
$(M(module.kinds:get_section_description(kind),nil))
#   if kitem then
#     if has_description then
$(M(ldoc.descript(kitem),kitem))

#     end -- if has_description
#     if kitem.usage then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Usage:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$(ldoc.prettify(kitem.usage[1]))

#     end -- if kitem.usage
#   end -- if kitem

#   for item in items() do
#     if not item.name:match(" :") then
.. _$(module.name).$(item.name):
#     end

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$(display_name(item))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$(M(ldoc.descript(item),item))

#     if ldoc.custom_tags then
#       for custom in iter(ldoc.custom_tags) do
#         local tag = item.tags[custom[1]]
#         if tag and not custom.hidden then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$(custom.title or custom[1]): custom
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#           for value in iter(tag) do
- $(custom.format and custom.format(value) or M(value))
#           end -- for
#         end -- if tag
#       end -- iter tags
#     end
#     if show_parms and item.params and #item.params > 0 then
#       local subnames = module.kinds:type_of(item).subnames
#       if subnames then
**$(subnames):**

#       end
#       for parm in iter(item.params) do
#         local param,sublist = item:subparam(parm)
#         local tab = ''
#         if sublist then tab = '  '
- *$(sublist):* $(rem_newlines(M(item.params.map[sublist],item)))

#         end
#         for p in iter(param) do
#           local name,tp,def = item:display_name_of(p), ldoc.typename(item:type_of_param(p)), item:default_of_param(p)
#           local prop_type = ''
#           if def == true then
#             prop_type = '(optional)'
#           elseif def then
#             prop_type = '(default $(def))'
#           end
#           local read_only = ''
#           if item:readonly(p) then
#             read_only = 'readonly'
#           end
$(tab)- *$(name):* $(tp) $(rem_newlines(M(item.params.map[p],item))) $(trim(prop_type)) $(trim(read_only))
#         end
#         if sublist then

#         end
#       end -- for
#     end -- if params

#     if show_return and item.retgroups then local groups = item.retgroups
**Returns**:

#       for i,group in ldoc.ipairs(groups) do
#         for r in group:iter() do local type, ctypes = item:return_type(r); local rt = ldoc.typename(type)
#           local prop_type = ''
#           if rt ~= '' then
#             rt = rt..' '
#           end
$(rt)$(ldoc.escape(M(r.text,item)))
#           if ctypes then
#             for c in ctypes:iter() do
   - $(c.name) $(ldoc.typename(c.type)) $(M(c.comment,item))
#             end
#           end -- if ctypes
#         end -- for r
#         if i < #groups then

**Or**

#         end
#       end -- for group
#     end -- if returns

#     if show_return and item.raise then
**Raises:**

$(M(item.raise,item))

#     end
#     if item.see then
**See also:**

#       for see in iter(item.see) do
- $(ldoc.href(see))
#       end -- for

#     end -- if see
#     if item.usage then
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Usage:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#       for usage in iter(item.usage) do
$(ldoc.prettify(usage))
#       end -- for

#     end -- if usage
#   end -- for items
# end -- for kinds
# else -- if module; project-level contents
# if ldoc.description then
-------------------------------------------------------------------------------
$(M(ldoc.description,nil))
-------------------------------------------------------------------------------
# end
# if ldoc.full_description then
$(M(ldoc.full_description,nil))
# end
===============================================================================
$(ldoc.toctree)
===============================================================================

.. toctree::
   :maxdepth: 1

# for kind, mods in ldoc.kinds() do
#   kind = kind:lower()
#   for m in mods() do
   $(kind)/$(m.name)
#   end -- for modules

# end -- for kind
# end -- if module
]==]
