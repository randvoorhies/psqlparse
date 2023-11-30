import json

from .nodes.utils import build_from_obj
from .exceptions import PSqlParseError
from .pg_query cimport (pg_query_parse, pg_query_free_parse_result)


def parse_dict(query, cleanup=True):
    cdef bytes encoded_query

    if isinstance(query, str):
        encoded_query = query.encode('utf8')
    elif isinstance(query, bytes):
        encoded_query = query
    else:
        encoded_query = str(query).encode('utf8')

    result = pg_query_parse(encoded_query)
    if result.error:
        error = PSqlParseError(result.error.message.decode('utf8'),
                               result.error.lineno, result.error.cursorpos)
        pg_query_free_parse_result(result)
        raise error

    statement_dicts = json.loads(result.parse_tree.decode('utf8'),
                                 strict=False)
    pg_query_free_parse_result(result)
    
    if cleanup:
        return [statement['stmt'] for statement in statement_dicts['stmts']]
    else:
        return statement_dicts


def parse(query):
    return [build_from_obj(obj) for obj in parse_dict(query)]
