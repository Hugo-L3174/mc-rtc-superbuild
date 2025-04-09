# If rename CMakeLists.txt of superbuild extensions to cmake they are not picked up
# automatically. This can be used to activate them optionally with
# include(${CMAKE_CURRENT_LIST_DIR}/helpup-controller-superbuild/helpup-controller-superbuild.cmake)
set(EXTENSIONS_DIR ${CMAKE_CURRENT_LIST_DIR}/superbuild-extensions)
include(${EXTENSIONS_DIR}/gui/mc_rtc-magnum.cmake)

# include(${EXTENSIONS_DIR}/interfaces/mc_mujoco.cmake) including my version of
# mc_mujoco cmake instead of the superbuild extensions one
include(${EXTENSIONS_DIR}/simulation/MuJoCo.cmake)

AddProject(
  mc_mujoco
  GITHUB Hugo-L3174/mc_mujoco
  GIT_TAG origin/main
  CMAKE_ARGS -DMUJOCO_ROOT_DIR=${MUJOCO_ROOT_DIR}
  DEPENDS mc_rtc
  APT_PACKAGES libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libglew-dev
)

# Robots mujoco descriptions

if(WITH_HRP5)
  AddProject(
    hrp5p_mj_description
    GITHUB_PRIVATE isri-aist/hrp5p_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

if(WITH_HRP4CR)
  AddProject(
    hrp4cr_mj_description
    GITHUB_PRIVATE isri-aist/hrp4cr_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

if(WITH_HRP4)
  AddProject(
    hrp4_mj_description
    GITE hlefevre/hrp4_mj_description
    GIT_TAG origin/master
    DEPENDS mc_mujoco hrp4_description
  )
endif()

if(WITH_HUMAN)
  AddProject(
    human_mj_description
    GITHUB Hugo-L3174/human_description
    GIT_TAG origin/topic/mujoco
    DEPENDS mc_mujoco human_description
  )
endif()

if(WITH_RHPS1)
  AddProject(
    rhps1_mj_description
    GITHUB_PRIVATE Hugo-L3174/rhps1_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco rhps1_description
  )
endif()
