{% macro remove_double_quotes(column_name, to_extract) -%}
    replace(json_extract({{column_name}}, '{{to_extract}}'), '"', '')
{%- endmacro %}
