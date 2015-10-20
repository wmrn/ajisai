//ajisai.pde
//梅雨の紫陽花（水弾ける）
//2015/07/20
//1-3-48 marina wada



/*クリックしたらしずくが落ちはじめて、
 葉っぱに当たると弾けます。(すべての葉っぱに対応）*/



//音楽準備
import ddf.minim.*;
Minim minim;
AudioPlayer bgm;//BGM音楽ならす
AudioSnippet crashD;//効果音D音楽ならす



//アジサイの１片を描く「関数」（水色）
void flowerD(float centerx, float centery, float angle_deg) {
  pushMatrix();
  translate(centerx, centery);
  rotate(radians(angle_deg));
  fill(127, 229, 255);
  strokeWeight(1);
  stroke(7, 101, 178);
  quad(0, 0, -25, -35, 0, -50, 25, -35);//花びら
  quad(0, 0, -35, -25, -50, 0, -35, 25);
  quad(0, 0, -25, 35, 0, 50, 25, 35);
  quad(0, 0, 35, -25, 50, 0, 35, 25);
  popMatrix();
  pushMatrix();//↓ここから内側の模様の描写
  translate(centerx, centery);
  rotate(radians(angle_deg));
  for (int i=0; i<7; i++) {//+を何回もまわす「繰り返し」
    if (i>=1) {//初回は+9度しないように最初かどうかを判定する「条件分岐」
      rotate(PI/20);//9度ずつ回してる
    }
    stroke(255, 180);
    line(-18, 8, 18, -8);//元は＋型になってる
    line(-8, -18, 8, 18);
  }
  stroke(7, 101, 178);
  ellipse(0, 0, 7, 7);//真ん中の丸
  popMatrix();
}



//アジサイの１片を描く「関数」（ピンク）
void flowerU(float centerx, float centery, float angle_deg) {
  pushMatrix();
  translate(centerx, centery);
  rotate(radians(angle_deg));
  fill(234, 168, 230);
  strokeWeight(1);
  stroke(237, 52, 224);
  quad(0, 0, -25, -35, 0, -50, 25, -35);//花びら
  quad(0, 0, -35, -25, -50, 0, -35, 25);
  quad(0, 0, -25, 35, 0, 50, 25, 35);
  quad(0, 0, 35, -25, 50, 0, 35, 25);
  popMatrix();
  pushMatrix();//↓ここから内側の模様の描写
  translate(centerx, centery);
  rotate(radians(angle_deg));
  for (int i=0; i<7; i++) {//+を何回も回す「繰り返し」
    if (i>=1) {//初回は+9度しないように最初かどうかを判定する「条件分岐」
      rotate(PI/20);//9度ずつ回してる
    }
    stroke(255, 180);
    line(-18, 8, 18, -8);//元は＋型になってる
    line(-8, -18, 8, 18);
  }
  stroke(239, 148, 232);
  ellipse(0, 0, 7, 7);//真ん中の丸
  popMatrix();
}



//葉っぱの「関数」（緑）
void leafeG(float leafex, float leafey, float scale_factor, float angle_deg ) {
  pushMatrix();
  translate(leafex, leafey);
  scale(scale_factor);
  rotate(PI+radians(angle_deg));
  fill(43, 175, 43);
  strokeWeight(1);
  stroke(30, 122, 30); 
  bezier(-150, 0, -100, -250, 150, -150, 250, 0);//広葉上
  bezier(-150, 0, -100, 250, 150, 150, 250, 0);//広葉下
  strokeWeight(5);
  stroke(52, 209, 52);
  line(-175, 0, 248, 0);//芯
  strokeWeight(1);
  stroke(241, 255, 206);
  bezier(-130, 0, -120, -50, -100, -140, -45, -137);//筋1（茎側から）
  bezier(-130, 0, -120, 50, -100, 140, -45, 137);
  bezier(-60, 0, -50, -40, -30, -120, 58, -141);//2
  bezier(-55, 0, -47, 40, 10, 130, 61, 141);
  bezier(0, 0, 5, -30, 60, -100, 140, -105);//3
  bezier(15, 0, 20, 30, 140, 120, 145, 105);
  bezier(80, 0, 83, -20, 178, -80, 198, -65);//4
  bezier(105, 0, 108, 20, 228, 75, 203, 60);
  popMatrix();
}



//しずく(横ver)の「関数」
void drop1(float x, float y) {
  stroke(51, 92, 136, 100);
  fill(205, 231, 242, 102);
  ellipse(x, y, 50, 30);//しずく本体
  fill(255);
  pushMatrix();
  translate(x, y);
  rotate(radians(45.0));
  noStroke();
  ellipse(-13, 7, 8, 18);//光沢
  popMatrix();
}



//しずく(丸ver)の「関数」
void drop2(float x, float y) {
  stroke(51, 92, 136, 100);
  fill(205, 231, 242, 102);
  ellipse(x, y, 30, 30);//しずく本体
  fill(255);
  pushMatrix();
  translate(x, y);
  rotate(radians(45.0));
  noStroke();
  ellipse(-10, 0, 6, 12);//光沢
  popMatrix();
}



//しずく(縦ver)の「関数」
void drop3(float x, float y) {
  stroke(51, 92, 136, 100);
  fill(205, 231, 242, 102);
  ellipse(x, y, 30, 50);//しずく本体
  fill(255);
  pushMatrix();
  translate(x, y);
  rotate(radians(30.0));
  noStroke();
  ellipse(-10, -7, 8, 18);//光沢
  popMatrix();
}



//はじく様子の「関数」
void spit(float x, float y) {
  fill(255);
  ellipse(x+50, y-10, 10, 10);//水しぶき
  ellipse(x+30, y-20, 10, 10);
  ellipse(x-30, y-20, 10, 10);
  ellipse(x-50, y-10, 10, 10);
}



//雨Aの「関数」
void rainA(float x, float y) {
  stroke(0, 0, 255);
  noFill();
  for (int i=0; i<4; i++) {//点線を書くための「繰り返し」
    line(x, y+i*20+10, x, y+i*20);//「- - - -」これを縦にした感じ
  }
  ellipse(x, y+90, 7, 7);//一番下にしずくをイメージした丸
}



//雨Bの「関数」
void rainB(float x, float y) {
  stroke(82, 188, 222);
  noFill();
  for (int i=0; i<4; i++) {//点線を書くための「繰り返し」
    line(x, y+i*20+10, x, y+i*20);//「- - - -」これを縦にした感じ
  }
  ellipse(x, y+90, 7, 7);//一番下にしずくをイメージした丸
}



//アジサイUの1片の位置と角度を決める「配列」
float putUx [] =new float [150];
float putUy [] =new float [150];
float angleU []=new float [150];



//アジサイDの1片の位置と角度を決める「配列」
float putDx [] =new float [250];
float putDy [] =new float [250];
float angleD [] =new float [250];



//しずくの「配列」
float [] x=new float [8];
float [] y=new float [8];
float [] speed=new float [8];
int flag=0;//しずくの番号の振り分け
int[] count=new int [8];//しずくのverを決める数








void setup() {

  size(800, 700);



  //BGM音楽のロードとループ
  minim=new Minim(this);
  bgm=minim.loadFile("Rain-Real.mp3");
  bgm.play();
  bgm.loop();

  //効果音Dのロード
  minim = new Minim(this);
  crashD = minim.loadSnippet("dropD.mp3");



  //アジサイUの1片の位置の配列に「繰り返し」代入
  for (int i=0; i<150; i++) {
    putUx[i]=random(-250, 250);
    putUy[i]=random(-130, 130);
    angleU[i]=i*10;//花がすべて同じ向きにならないように少しずつずらしてる
    //アジサイUの形に合わなかったものは代入し直す「条件分岐」
    if (pow(putUx[i], 2)/pow(250, 2)+pow(putUy[i], 2)/pow(130, 2)>=1.0) {
      putUx[i]=random(-200, 200);
      putUy[i]=random(-100, 100);
      angleU[i]=i*10;
    }
  }




  //アジサイDの1片の位置の配列に「繰り返し」代入
  for (int j=0; j<250; j++) {
    putDx[j]=random(-230, 230);
    putDy[j]=random(-230, 230);
    angleD[j]=j*10;//花がすべて同じ向きにならないように少しずつずらしてる
    //アジサイDの形に合わなかったものは代入し直す「条件分岐」
    if (pow(putDx[j], 2)/pow(230, 2)+pow(putDy[j], 2)/pow(230, 2)>=1.0) {
      putDx[j]=random(-190, 190);
      putDy[j]=random(-190, 190);
      angleD[j]=j*10;
    }
  }




  //しずくの配列に「繰り返し」代入
  for (int i=0; i<8; i++) {
    x[i]=800;
    y[i]=700;
    speed[i]=0;
  }
}








void draw() {

  background(218, 234, 247);



  rainA(random(800), random(700));//雨の背景
  rainB(random(800), random(700));
  rainA(random(800), random(700));



  leafeG(310, 600, 1, 10);//あじさいDの緑の葉っぱ
  leafeG(700, 350, 1, 95);
  leafeG(200, 100, 0.6, 120);//あじさいUの緑の葉っぱ
  leafeG(100, 280, 0.6, -65);
  leafeG(300, 260, 0.6, -150);



  //あじさいUの表示
  pushMatrix();
  translate(100, 175);
  for (int i=0; i<150; i++) {//あじさいの花の描画のための「繰り返し」
    flowerU(putUx[i], putUy[i], angleU[i]);
  }
  popMatrix();



  //しずくを落としてはじける（あじさいDの上を通らないようにこの順番）
  for (int i=0; i<8; i++) {//しずくのそれぞれの状態確認のための「繰り返し」
    if (0<=count[i] && count[i]<=1) {//countの数によってしずくのverを変える「条件分岐」
      drop2(x[i], y[i]);//クリックされた瞬間は丸verのしずく
    } else if (1<count[i] ) {        
      if (get((int)x[i], (int)y[i])==-13914325) {//葉っぱの上の色かどうかによって反応を変える「条件分岐」
        drop1(x[i], y[i]);//葉っぱの上では横verのしずく
        spit(x[i], y[i]);//はねた時の水しぶき
        crashD.rewind();//効果音再生
        crashD.play();
        x[i]=800;//はねたら見えないとこに移動して消えさせる
        y[i]=800;
      } else {
        drop3(x[i], y[i]);//はねる前までは縦verのしずく
      }
    }
    y[i]+=speed[i];//下に移動
    count[i]++;//カウント1ずつ増加
  }



  //あじさいDの表示
  pushMatrix();
  translate(650, 550);
  for (int i=0; i<250; i++) {//あじさいの花の描画のための「繰り返し」
    flowerD(putDx[i], putDy[i], angleD[i]);
  }
  popMatrix();
}







void mousePressed() {

  flag++;//クリックされるごとにflagを1ずつ増加
  for (int i=0; i<8; i++) {//しずくのそれぞれの状態確認のための「繰り返し」
    if (flag%8==i) {//flagを8で割った余りでどのしずくかを判別する「条件分岐」
      x[i]=mouseX;//クリックされたマウスの位置から開始
      y[i]=mouseY;
      speed[i]=5;//スピード指定
      count[i]=0;//カウント開始
    }
  }
}







void stop() {

  bgm.close();//BGMを止める
  crashD.close();//効果音Dを止める
  minim.stop();
  super.stop();
}

