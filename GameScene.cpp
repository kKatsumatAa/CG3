#include "GameScene.h"
#include <cassert>
#include <random>

using namespace DirectX;

GameScene::GameScene()
{
}

GameScene::~GameScene()
{
	delete spriteBG;

	delete particleM;

	delete sprite1;
	delete sprite2;
}

void GameScene::Initialize(DirectXCommon* dxCommon, Input* input)
{
	// nullptrチェック
	assert(dxCommon);
	assert(input);

	this->dxCommon = dxCommon;
	this->input = input;

	// デバッグテキスト用テクスチャ読み込み
	Sprite::LoadTexture(debugTextTexNumber, L"Resources/debugfont.png");
	// デバッグテキスト初期化
	debugText.Initialize(debugTextTexNumber);

	// テクスチャ読み込み
	Sprite::LoadTexture(1, L"Resources/background.png");

	// 背景スプライト生成
	spriteBG = Sprite::Create(1, { 0.0f,0.0f });

	//テクスチャ２番に読み込み
	Sprite::LoadTexture(2, L"Resources/texture.png");
	//スプライト生成
	sprite1 = Sprite::Create(2, { 0,0 });
	sprite2 = Sprite::Create(2, { 500,500 }, { 1,0,0,1 }, { 0,0 }, false, true);

	// 3Dオブジェクト生成

	particleM = ParticleManager::Create();
	particleM->Update(input);

	particleM->SetEye({ 0, 0, -30 });
}

int count = 0;
int count2 = 0;
void GameScene::Update()
{
	count++;

	if (input->TriggerKey(DIK_SPACE))
	{
		count2++;
		if (count2 >= 2)count2 = 0;
	}

	debugText.Print("SPACE:mode", 10, 10, 1.0f);

	if (count2 == 0) debugText.Print("colorful", 10, 30, 1.0f);
	if (count2 == 1) debugText.Print("gradation", 10, 30, 1.0f);
	

	if (count % 5 == 0)
	{
		for (int i = 0; i < 100; i++)
		{
			//XYZ全て[-5.0f~+5.0f]でランダムに分布
			const float md_pos = 10.0f;
			XMFLOAT3 pos{};
			pos.x = (float)rand() / RAND_MAX * md_pos - md_pos / 2.0f;
			pos.y = (float)rand() / RAND_MAX * md_pos - md_pos / 2.0f;
			pos.z = (float)rand() / RAND_MAX * md_pos - md_pos / 2.0f;

			//XYZ全て[-0.05~+0.05f]でランダムに分布
			const float md_vel = 0.1f;
			XMFLOAT3 vel{};
			vel.x = (float)rand() / RAND_MAX * md_vel - md_vel / 2.0f;
			vel.y = (float)rand() / RAND_MAX * md_vel - md_vel / 2.0f;
			vel.z = (float)rand() / RAND_MAX * md_vel - md_vel / 2.0f;

			//重力に見立ててYのみ[-0.001f~0]でランダムに
			XMFLOAT3 acc{};
			const float md_acc = 0.001f;
			acc.y = -(float)rand() / RAND_MAX * md_acc;

			//色
			XMFLOAT4 color{};
			const float md_color = 1.0f;
			color.x = (float)rand() / RAND_MAX * md_color;
			color.y = (float)rand() / RAND_MAX * md_color;
			color.z = (float)rand() / RAND_MAX * md_color;
			color.w = (float)rand() / RAND_MAX * md_color;

			if (count2 == 0)
				particleM->Add(60, pos, vel, acc, 1.0f, 0.0f
					, color, color);
			else if (count2 == 1)
				particleM->Add(180, pos, vel, acc, 1.0f, 0.0f
					, { 0.0f,0.0f,1.0f,1.0f }, { 1.0f,1,0,1.0f });
		}
	}

	//スペースキーを押していたら
	if (input->PushKey(DIK_SPACE))
	{
		XMFLOAT2 pos = sprite1->GetPos();
		pos.x += 1.0f;

		sprite1->SetPosition(pos);
	}

	// カメラ移動
	if (input->PushKey(DIK_W) || input->PushKey(DIK_S) || input->PushKey(DIK_D) || input->PushKey(DIK_A))
	{
		if (input->PushKey(DIK_W)) { ParticleManager::CameraMoveEyeVector({ 0.0f,+1.0f,0.0f }); }
		else if (input->PushKey(DIK_S)) { ParticleManager::CameraMoveEyeVector({ 0.0f,-1.0f,0.0f }); }
		if (input->PushKey(DIK_D)) { ParticleManager::CameraMoveEyeVector({ +1.0f,0.0f,0.0f }); }
		else if (input->PushKey(DIK_A)) { ParticleManager::CameraMoveEyeVector({ -1.0f,0.0f,0.0f }); }
	}


	particleM->Update(input);

}

void GameScene::Draw()
{
	// コマンドリストの取得
	ID3D12GraphicsCommandList* cmdList = dxCommon->GetCommandList();

#pragma region 背景スプライト描画
	// 背景スプライト描画前処理
	Sprite::PreDraw(cmdList);
	// 背景スプライト描画
	spriteBG->Draw();
	/*sprite1->Draw();
	sprite2->Draw();*/

	/// <summary>
	/// ここに背景スプライトの描画処理を追加できる
	/// </summary>

	// スプライト描画後処理
	Sprite::PostDraw();
	// 深度バッファクリア
	dxCommon->ClearDepthBuffer();
#pragma endregion

#pragma region 3Dオブジェクト描画
	// 3Dオブジェクト描画前処理
	ParticleManager::PreDraw(cmdList);

	// 3Dオブクジェクトの描画
	particleM->Draw();


	/// <summary>
	/// ここに3Dオブジェクトの描画処理を追加できる
	/// </summary>

	// 3Dオブジェクト描画後処理
	ParticleManager::PostDraw();
#pragma endregion

#pragma region 前景スプライト描画
	// 前景スプライト描画前処理
	Sprite::PreDraw(cmdList);

	/// <summary>
	/// ここに前景スプライトの描画処理を追加できる
	/// </summary>
	// デバッグテキストの描画
	debugText.DrawAll(cmdList);

	// スプライト描画後処理
	Sprite::PostDraw();
#pragma endregion
}
