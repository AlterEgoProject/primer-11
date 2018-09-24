// 共振モデル
class Resonance{
  float x; // 位置
  float v; // 速度
  float EIGEN; // 固有周波数
  float DELTA; // 1フレームの時間
  float K; // バネ係数
  
  // コンストラクタ(固有周波数,フレームレート,初期位置,初期速度)
  Resonance(float eigen, float frame_rate, float x, float v){
    if(eigen<=0){println("error!(constructor in Resonance) : EIGEN must be positive");System.exit(0);}
    this.x = x;
    this.v = v;
    this.EIGEN = eigen;
    this.DELTA = 1./frame_rate;
    this.K = pow(2*PI*eigen,2); // (2πf)^2
  }
  // 初期の位置と速度は省略可能
  Resonance(float eigen, float frame_rate){
    this(eigen,frame_rate,0.,0.);
  }
  
  void move(float external){
    this.v += (-this.K*this.x + external) * this.DELTA; // F = 弾性力 + 外力
    this.x += this.v * this.DELTA;
  }
}
