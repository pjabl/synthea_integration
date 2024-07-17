{% macro to_timestamp(column_name) -%}
    case
            when regexp_contains(column_name, r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{7}Z')
                then
                    timestamp(
                        substr(column_name, 1, 19)
                        || '.'
                        || substr(column_name, 21, 6)
                        || 'Z'
                    )
            else
                timestamp(column_name)
        end
{%- endmacro %}
