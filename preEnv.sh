ls
echo "****************************************"
echo "****************************************"
git config --global user.name "291019874@qq.com"
git config --global user.email "291019874@qq.com"
git config --global user.password "dpp_123"
git config --global --list
echo "****************************************"
mkdir huoshan
cp -r ../cache_script_darwin ./huoshan
cp -r ../cloud_build_service_inner_init.sh ./huoshan
cp -r ../get_mobileprovision_info.py ./huoshan

echo "****************************************"
echo "****************************************"
ls && cd huoshan && ls
echo "****************************************"
echo "****************************************"

git add .
git commit -m "cache_script_darwin"
git push --set-upstream origin source

echo "******************当前进程**********************"
echo "******************当前进程**********************"
echo "******************当前进程**********************"
ps -ef
echo "******************当前进程**********************"
echo "******************当前进程**********************"
echo "******************当前进程**********************"

