const { PinpointClient, CreateCampaignCommand } = require("@aws-sdk/client-pinpoint");

const pinpointClient = new PinpointClient({ region: "eu-central-1" });

const createCampaingCommand = new CreateCampaignCommand({
  ApplicationId: "d4d79d8577b74738978a042239860276",
  WriteCampaignRequest: {
    AdditionalTreatments: [],
    Name: "New Recipe Campaign",
    SegmentId: "f6df39fc56b54937b5fc86b06d90251a",
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
        Body: "Check out this new recipe!",
        Title: "New Recipe",
      },
      APNSMessage: {
        Action: "OPEN_APP",
        Body: "Check out this new recipe!",
        Title: "New Recipe",
      },
      GCMMessage: {
        Action: "OPEN_APP",
        Body: "Check out this new recipe!",
        Title: "New Recipe",
      },
      BaiduMessage: {
        Action: "OPEN_APP",
        Body: "Check out this new recipe!",
        Title: "New Recipe",
      },
      ADMMessage: {
        Action: "OPEN_APP",
        Body: "Check out this new recipe!",
        Title: "New Recipe",
      }
    }
  },
});

/*
* @type { import('@types/aws-lambda').APIGatewayProxyHandler }
*/

exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  for (const record of event.Records) {
    if (record.eventName === 'INSERT') {
      try {
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
