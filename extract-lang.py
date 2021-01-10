import yaml
import sys

def find_languges(yaml, starting_list = []):
    lang_list = starting_list
    if isinstance(yaml, dict):
        for k in yaml.keys():
            if k == 'lang':
                lang_list.append(yaml[k])
            elif isinstance(yaml[k], list):
                for l in yaml[k]:
                    find_languges(l, lang_list)
            elif isinstance(yaml[k], dict):
                find_languges(yaml[k], lang_list)
    elif isinstance(yaml, list):
        for l in yaml:
            find_languges(l, lang_list)
    return lang_list

def find_engines(yaml, starting_list = []):
    engine_list = starting_list
    if isinstance(yaml, dict):
        for k in yaml.keys():
            if k == 'aspell' or k == 'hunspell':
                engine_list.append(k)
            elif isinstance(yaml[k], list):
                for l in yaml[k]:
                    find_engines(l, engine_list)
            elif isinstance(yaml[k], dict):
                find_engines(yaml[k], engine_list)
    elif isinstance(yaml, list):
        for l in yaml:
            find_engines(l, engine_list)
    return engine_list

with open(sys.argv[1], 'r') as file:
    yaml = yaml.load(file, Loader=yaml.FullLoader)
    lang_list = find_languges(yaml)
    engine_list = find_engines(yaml)
    
    output_string = ''
    
    for e in engine_list:
        for l in lang_list:
            output_string += ' ' + e + '-' + l
            
    print(output_string)