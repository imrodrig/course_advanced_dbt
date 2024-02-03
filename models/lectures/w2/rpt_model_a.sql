select database_name, database_owner
from {{ source('others', 'databases') }}
