import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/62502104?s=400&v=4'),
              radius: 20.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Chats',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_rounded,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 86.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => buildstoryItem(),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.0,
                      ),
                  itemCount: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/62502104?s=400&v=4'),
                  radius: 25.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 8.5,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 2.0, bottom: 2.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 6.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mina Samir AbdElMaseeh',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(

                    children: [
                      Expanded(
                        child: Text(
                          'Mina Samir AbdElMaseeh Mina Samir AbdElMaseeh Mina Samir AbdElMaseeh Mina Samir AbdElMaseeh',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                      ),
                      Text(
                        '02:00 pm',
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
  );

  Widget buildstoryItem() => Container(
        width: 60.0,
        padding: EdgeInsetsDirectional.only(end: 10.0),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/62502104?s=400&v=4'),
                  radius: 25.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 8.5,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 2.0, bottom: 2.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 6.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'Mina Samir AbdElMaseeh',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
}
