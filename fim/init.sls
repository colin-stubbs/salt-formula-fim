{% from "fim/map.jinja" import fim_settings with context %}

{# check directories and optionally recurse to files if requested #}
{% if 'directory' in fim_settings %}
{% for directory_name, directory_config in fim_settings.directory.items() %}
fim-{{ directory_name }}:
{% if 'source' in directory_config %}
  file.recurse:
{% else %}
  file.directory:
{% endif %}
    - name: {{ directory_name }}
    {% for key, value in directory_config.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}{% endfor %}
{% endif %}

{# check individual files #}
{% if 'file' in fim_settings %}
{% for filename, file_config in fim_settings.file.items() %}
fim-{{ filename }}:
  file.managed:
    - name: {{ filename }}
    {% for key, value in file_config.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{# EOF #}
