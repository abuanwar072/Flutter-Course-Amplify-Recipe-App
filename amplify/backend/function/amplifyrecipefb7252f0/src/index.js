const { PinpointClient, CreateCampaignCommand } = require("@aws-sdk/client-pinpoint");

const pinpointClient = new PinpointClient({ region: "eu-central-1" });

/*
* @type { import('@types/aws-lambda').APIGatewayProxyHandler }
*/

exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  for (const record of event.Records) {
    if (record.eventName === 'INSERT') {
      try {
        let recipeTitle = record.dynamodb.NewImage.title.S;
        let recipeDescription = record.dynamodb.NewImage.description.S;
        let recipeId = record.dynamodb.NewImage.id.S;
        const createCampaingCommand = new CreateCampaignCommand({
          ApplicationId: "357c824c055f4213a6632f9486666550",
          WriteCampaignRequest: {
            AdditionalTreatments: [],
            Name: "Campaign: " + recipeId.substring(0, 50) + "!",
            SegmentId: "afced6a65fdd467d8e11e6848331e1ee",
            SegmentVersion: 1,
            HoldoutPercent: 0,
            TemplateConfiguration: {},
            Limits: {
              MessagesPerSecond: 20000,
              MaximumDuration: 10800,
              Daily: 0,
              Total: 0,
            },
            Schedule: {
              IsLocalTime: false,
              QuietTime: {},
              StartTime: "IMMEDIATE",
              Timezone: "UTC",
            },
            MessageConfiguration: {
              DefaultMessage: {
                Action: "OPEN_APP",
                Title: "New Recipe!",
                Body: "Check out: " + recipeTitle + "!",
                JsonBody: JSON.stringify({
                  recipeId: recipeId,
                  recipeTitle: recipeTitle,
                  recipeDescription: recipeDescription,
                }),
              },
              APNSMessage: {
                Action: "OPEN_APP",
                Title: "New Recipe!",
                Body: "Check out: " + recipeTitle + "!",
                JsonBody: JSON.stringify({
                  recipeId: recipeId,
                  recipeTitle: recipeTitle,
                  recipeDescription: recipeDescription,
                }),
              },
              GCMMessage: {
                Action: "OPEN_APP",
                Title: "New Recipe!",
                Body: "Check out: " + recipeTitle + "!",
                JsonBody: JSON.stringify({
                  recipeId: recipeId,
                  recipeTitle: recipeTitle,
                  recipeDescription: recipeDescription,
                }),
              },
              BaiduMessage: {
                Action: "OPEN_APP",
                Title: "New Recipe!",
                Body: "Check out: " + recipeTitle + "!",
                JsonBody: JSON.stringify({
                  recipeId: recipeId,
                  recipeTitle: recipeTitle,
                  recipeDescription: recipeDescription,
                }),
              },
              ADMMessage: {
                Action: "OPEN_APP",
                Title: "New Recipe!",
                Body: "Check out: " + recipeTitle + "!",
                JsonBody: JSON.stringify({
                  recipeId: recipeId,
                  recipeTitle: recipeTitle,
                  recipeDescription: recipeDescription,
                }),
              }
            }
          },
        });
        const data = await pinpointClient.send(createCampaingCommand);
        console.log('Send Message Respond: %j', data);
      } catch (error) {
        console.log('Pinpoint error: %j', error);
      } finally {
        console.log('Pinpoint finally finished.');
      }
    }
  }
};