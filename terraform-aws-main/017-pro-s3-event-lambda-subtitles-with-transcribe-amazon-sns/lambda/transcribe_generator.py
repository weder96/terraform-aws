import boto3

s3  = boto3.client('s3')
transcribe = boto3.client('transcribe')

def create_uri(bucket_name, file_name):
    return "s3://"+bucket_name+"/"+file_name

def lambda_handler(event, context):
    
    #parse out the bucket & file name from the event handler
    for record in event['Records']:

        bucket_name = record['s3']['bucket']['name']
        file_name = record['s3']['object']['key']
        object_url = create_uri(bucket_name, file_name)
        print("object_url :"+ object_url) 
            
        response = transcribe.start_transcription_job(
            TranscriptionJobName=file_name.replace('/','')[:10],
            IdentifyLanguage=True,
            Subtitles={
                'Formats': ['srt']
            },
            Media={
                'MediaFileUri': object_url
            },
            OutputBucketName = "my-s3-target-sousaw96-bucket-v1"
        )
        
    return {
        'TranscriptionJobName': response['TranscriptionJob']['TranscriptionJobName']
        
    }