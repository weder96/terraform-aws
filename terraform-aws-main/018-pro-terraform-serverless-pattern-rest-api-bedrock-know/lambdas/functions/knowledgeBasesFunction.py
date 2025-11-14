import boto3
import json

def lambda_handler(event, context):
    client = boto3.client('bedrock-agent-runtime', region_name='us-east-1')

    session_id = event.get('sessionId', None)

    query_params = event.get('queryStringParameters', {})
    if 'query' not in query_params:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Query parameter is missing'}),
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'}
        }

    # Extraindo a consulta do evento
    query = query_params['query']

    # https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/bedrock-agent-runtime/client/retrieve_and_generate.html

    input_data = {
        'input': {
            'text': str(query)
        },
        'retrieveAndGenerateConfiguration': {
            'knowledgeBaseConfiguration': {
                'knowledgeBaseId': 'S62BWLZ0AD',
                'modelArn': 'arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0'
            },
            'type': 'KNOWLEDGE_BASE'
        }
    }

    # SessionId
    if session_id:
        input_data['sessionId'] = session_id

    print(input_data)

    response = {
        'statusCode': 200,
        'body': json.dumps(client.retrieve_and_generate(**input_data)),
        'headers': { 'Content-Type': 'application/json','Access-Control-Allow-Origin': '*'},
    }
    return response